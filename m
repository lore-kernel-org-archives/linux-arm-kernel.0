From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Feb 2014 18:10:28 +0000
Subject: [RESEND PATCH] ARM: kirkwood: select dtbs based on SoC
In-Reply-To: <1393350954-18767-1-git-send-email-jason@lakedaemon.net>
References: <1393350954-18767-1-git-send-email-jason@lakedaemon.net>
Message-ID: <1393351828-19087-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prevent problems later with mvebu_v5_defconfig builds, we restrict
the scope of the changes this series makes.

Selecting ARCH_KIRKWOOD and MACH_KIRKWOOD is necessary during the
migration from mach-kirkwood to mach-mvebu.  Until the last four legacy
kirkwood board files have a DT equivalent, we need to support building
DT from both mach-kirkwood and mach-mvebu.

Reported-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Sorry, forgot to include Kevin in the To:

If there are no complaints, I'll be applying this on top of Andrew's kirkwood
migration series in mvebu/soc-kw

 arch/arm/boot/dts/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e135182992b2..88010f97a368 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -117,6 +117,7 @@ kirkwood := \
 	kirkwood-ts219-6281.dtb \
 	kirkwood-ts219-6282.dtb
 dtb-$(CONFIG_ARCH_KIRKWOOD) += $(kirkwood)
+dtb-$(CONFIG_MACH_KIRKWOOD) += $(kirkwood)
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
 dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
@@ -133,8 +134,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-xp-gp.dtb \
 	armada-xp-netgear-rn2120.dtb \
 	armada-xp-matrix.dtb \
-	armada-xp-openblocks-ax3-4.dtb \
-	$(kirkwood)
+	armada-xp-openblocks-ax3-4.dtb
 dtb-$(CONFIG_ARCH_MXC) += \
 	imx25-karo-tx25.dtb \
 	imx25-pdk.dtb \
-- 
1.9.0
