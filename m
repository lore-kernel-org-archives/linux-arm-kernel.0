From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Nov 2014 11:32:32 +0000
Subject: [PATCH] arm64: Add FIX_HOLE to permanent fixed addresses
In-Reply-To: <1416960856-2944-1-git-send-email-lauraa@codeaurora.org>
References: <1416960856-2944-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20141126113232.GB14866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 12:14:16AM +0000, Laura Abbott wrote:
> Every other architecture with permanent fixed addresses has
> FIX_HOLE as the first entry. This seems to be designed as a
> debugging aid but there are a couple of side effects of not
> having FIX_HOLE:
> 
> - If the first fixed address is 0, fix_to_virt -> virt_to_fix
> triggers a BUG_ON for the virtual address being equal to
> FIXADDR_TOP
> - fix_to_virt may return a value outside of FIXADDR_START
> and FIXADDR_TOP which may look like a bug to a developer.
> 
> Match up with other architectures and make everything clearer
> by adding FIX_HOLE.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm64/include/asm/fixmap.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 5f7bfe6..424a10f 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -31,6 +31,7 @@
>   *
>   */
>  enum fixed_addresses {
> +	FIX_HOLE,
>  	FIX_EARLYCON_MEM_BASE,
>  	__end_of_permanent_fixed_addresses,

Looks sensible to me, thanks.

Will
