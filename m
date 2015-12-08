From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Dec 2015 12:07:44 +0000
Subject: [PATCH v4 01/13] mm/memblock: add MEMBLOCK_NOMAP attribute to
 memblock memory table
In-Reply-To: <CAKv+Gu9oboT_Lk8heJWRcM=oxRW=EWioVCvZLH7N0YCkfU5tJw@mail.gmail.com>
References: <1448886507-3216-1-git-send-email-ard.biesheuvel@linaro.org>
 <1448886507-3216-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9oboT_Lk8heJWRcM=oxRW=EWioVCvZLH7N0YCkfU5tJw@mail.gmail.com>
Message-ID: <20151208120743.GG19612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Thu, Dec 03, 2015 at 11:55:53AM +0100, Ard Biesheuvel wrote:
> On 30 November 2015 at 13:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > This introduces the MEMBLOCK_NOMAP attribute and the required plumbing
> > to make it usable as an indicator that some parts of normal memory
> > should not be covered by the kernel direct mapping. It is up to the
> > arch to actually honor the attribute when laying out this mapping,
> > but the memblock code itself is modified to disregard these regions
> > for allocations and other general use.
> >
> > Cc: linux-mm at kvack.org
> > Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  include/linux/memblock.h |  8 ++++++
> >  mm/memblock.c            | 28 ++++++++++++++++++++
> >  2 files changed, 36 insertions(+)

[...]

> May I kindly ask team-mm/Andrew/Alexander to chime in here, and
> indicate whether you are ok with this patch going in for 4.5? If so,
> could you please provide your ack so the patch can be kept together
> with the rest of the series, which depends on it?

I'm keen to queue this in the arm64 tree, since it's a prerequisite for
cleaning up a bunch of our EFI code and sharing it with 32-bit ARM.

> I should note that this change should not affect any memblock users
> that never set the MEMBLOCK_NOMAP flag, but please, if you see any
> issues beyond 'this may conflict with other stuff we have queued for
> 4.5', please do let me know.

Indeed, I can't see that this would cause any issues, but I would really
like an Ack from one of the MM maintainers before taking this.

Please could somebody take a look?

Will
