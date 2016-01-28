From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jan 2016 18:10:58 +0000
Subject: [PATCH] arm64: allow vmalloc regions to be set with set_memory_*
In-Reply-To: <CAKv+Gu-GxicSKDq+Nm9H+dWrSVOhupozu4pZ=Pk7CzC_VrW=2Q@mail.gmail.com>
References: <1453125665-26627-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160128150815.GG775@arm.com>
 <CAKv+Gu-GxicSKDq+Nm9H+dWrSVOhupozu4pZ=Pk7CzC_VrW=2Q@mail.gmail.com>
Message-ID: <20160128181058.GQ775@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 05:43:41PM +0100, Ard Biesheuvel wrote:
> On 28 January 2016 at 16:08, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Jan 18, 2016 at 03:01:05PM +0100, Ard Biesheuvel wrote:
> >> The range of set_memory_* is currently restricted to the module address
> >> range because of difficulties in breaking down larger block sizes.
> >> vmalloc maps PAGE_SIZE pages so it is safe to use as well. Update the
> >> function ranges and add a comment explaining why the range is restricted
> >> the way it is.
> >>
> >> Suggested-by: Laura Abbott <labbott@fedoraproject.org>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/mm/pageattr.c | 23 +++++++++++++++++++----
> >>  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > What's the user for this? It would be better to apply along with something
> > that actually needs to change permission for arbitrary vmalloc mappings.
> >
> 
> BPF already uses set_memory_ro() but doesn't bother to check the return value.

Urgh :(

Then I can take it as a fix, if you like.

Will
