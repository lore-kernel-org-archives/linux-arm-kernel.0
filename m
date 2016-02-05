From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 5 Feb 2016 14:34:04 +0000
Subject: [PATCHv3 3/3] arm64: ptdump: Indicate whether memory should be
 faulting
In-Reply-To: <1454615017-24672-4-git-send-email-labbott@fedoraproject.org>
References: <1454615017-24672-1-git-send-email-labbott@fedoraproject.org>
 <1454615017-24672-4-git-send-email-labbott@fedoraproject.org>
Message-ID: <20160205143403.GD19614@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:43:37AM -0800, Laura Abbott wrote:
> 
> With CONFIG_DEBUG_PAGEALLOC, pages do not have the valid bit
> set when free in the buddy allocator. Add an indiciation to
> the page table dumping code that the valid bit is not set,
> 'F' for fault, to make this easier to understand.
> 
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>

This looks sensible to me, and worked in testing.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/mm/dump.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
> index 5a22a11..f381ac9 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/dump.c
> @@ -90,6 +90,11 @@ struct prot_bits {
>  
>  static const struct prot_bits pte_bits[] = {
>  	{
> +		.mask	= PTE_VALID,
> +		.val	= PTE_VALID,
> +		.set	= " ",
> +		.clear	= "F",
> +	}, {
>  		.mask	= PTE_USER,
>  		.val	= PTE_USER,
>  		.set	= "USR",
> -- 
> 2.5.0
> 
