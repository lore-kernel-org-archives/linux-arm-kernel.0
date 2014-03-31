From: balbi@ti.com (Felipe Balbi)
Date: Mon, 31 Mar 2014 10:20:19 -0500
Subject: [PATCH 01/55] ARM: OMAP4: CM: use cm_base* in register address
 calculations
In-Reply-To: <1396278994-12624-2-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
 <1396278994-12624-2-git-send-email-t-kristo@ti.com>
Message-ID: <20140331152013.GD7760@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 06:15:40PM +0300, Tero Kristo wrote:
> OMAP44XX_CM*_REGADDR macros should be avoided, instead use the cm_base*
> iomaps.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/cm44xx.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
> index 535d66e..5627072 100644
> --- a/arch/arm/mach-omap2/cm44xx.c
> +++ b/arch/arm/mach-omap2/cm44xx.c
> @@ -30,23 +30,23 @@
>  /* Read a register in CM1 */
>  u32 omap4_cm1_read_inst_reg(s16 inst, u16 reg)
>  {
> -	return __raw_readl(OMAP44XX_CM1_REGADDR(inst, reg));
> +	return __raw_readl(cm_base + inst + reg);

should you use readl() or readl_relaxed() instead ? It'll take care of
endianness, right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140331/1a5bf62c/attachment.sig>
