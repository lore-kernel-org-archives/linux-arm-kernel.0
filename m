From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jan 2016 15:08:16 +0000
Subject: [PATCH] arm64: allow vmalloc regions to be set with set_memory_*
In-Reply-To: <1453125665-26627-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1453125665-26627-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160128150815.GG775@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 03:01:05PM +0100, Ard Biesheuvel wrote:
> The range of set_memory_* is currently restricted to the module address
> range because of difficulties in breaking down larger block sizes.
> vmalloc maps PAGE_SIZE pages so it is safe to use as well. Update the
> function ranges and add a comment explaining why the range is restricted
> the way it is.
> 
> Suggested-by: Laura Abbott <labbott@fedoraproject.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/mm/pageattr.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

What's the user for this? It would be better to apply along with something
that actually needs to change permission for arbitrary vmalloc mappings.

Anyway, with that (and a rebase to -rc2):

Acked-by: Will Deacon <will.deacon@arm.com>

Will
