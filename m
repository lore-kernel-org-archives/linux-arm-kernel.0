From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Sep 2012 20:52:09 +1000
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20120924205209.9b5e4eae732348f0d2b9ced8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/mach-exynos/Makefile.boot between commit 360a0cab5041 ("ARM:
move all dtb targets out of Makefile.boot") from the arm-soc tree and
commit d105f0b1215d ("ARM: dts: Add basic dts file for Samsung Trats
board") from the samsung tree.

I removed the bit from Makefile.boot and added the following merge fix
patch and can carry the fix as necessary (no action is required).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 24 Sep 2012 20:47:44 +1000
Subject: [PATCH] ARM: fix up for movemment of dtb targets

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/boot/dts/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d4ad2df..99e5e8e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -21,7 +21,7 @@ dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
 	dove-cubox.dtb \
 	dove-dove-db.dtb
 dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
-	exynos4210-smdkv310.dtb \
+	exynos4210-smdkv310.dtb exynos4210-trats.dtb \
 	exynos5250-smdk5250.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb
 dtb-$(CONFIG_ARCH_IMX5) += imx51-babbage.dtb \
-- 
1.7.10.280.gaa39

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/595447a1/attachment.sig>
