From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 31 Jan 2013 01:48:27 +1100
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20130131014827.09251ece97f74377abada4ac@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/mach-exynos/common.c between commit b533c8685b16 ("ARM: dts: fix
compatible value for exynos pinctrl") from the arm-soc tree and commit
d28a60d89c83 ("ARM: EXYNOS: skip wakeup interrupt registration for
exynos5250 if pinctrl is enabled") from the samsung tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-exynos/common.c
index 68c0689,cdaa55f..0000000
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@@ -1035,8 -1112,9 +1116,9 @@@ static int __init exynos_init_irq_eint(
  	 * interrupt support code here can be completely removed.
  	 */
  	static const struct of_device_id exynos_pinctrl_ids[] = {
 -		{ .compatible = "samsung,pinctrl-exynos4210", },
 -		{ .compatible = "samsung,pinctrl-exynos4x12", },
 -		{ .compatible = "samsung,pinctrl-exynos5250", },
 +		{ .compatible = "samsung,exynos4210-pinctrl", },
 +		{ .compatible = "samsung,exynos4x12-pinctrl", },
++		{ .compatible = "samsung,exynos5250-pinctrl", },
  	};
  	struct device_node *pctrl_np, *wkup_np;
  	const char *wkup_compat = "samsung,exynos4210-wakeup-eint";
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130131/2c7bfc4e/attachment.sig>
