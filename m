From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Feb 2014 18:11:42 +0000
Subject: [RESEND PATCH] ARM: mvebu: select dtbs from MACH_ARMADA_*
In-Reply-To: <1393350967-18819-1-git-send-email-jason@lakedaemon.net>
References: <1393350967-18819-1-git-send-email-jason@lakedaemon.net>
Message-ID: <1393351902-19151-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With kirkwood migrating into mach-mvebu, mvebu_v5_defconfig needs to
select ARCH_MVEBU.  Unfortunately, this means that when building a v5
kernel, we unnecessarily build dtbs for the armada v7 boards.

To fix this, we instead select based on MACH_ARMADA_* on a per SoC basis.

Reported-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Sorry, forgot to include Kevin in the To:

If there are no complaints, I'll be applying this to mvebu/dt

 arch/arm/boot/dts/Makefile | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 46c54a2dac71..1e6dbde1724e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -142,13 +142,17 @@ dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
 dtb-$(CONFIG_ARCH_MSM) += qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb \
 	qcom-apq8074-dragonboard.dtb
-dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
+dtb-$(CONFIG_MACH_ARMADA_370) += \
+	armada-370-db.dtb \
 	armada-370-mirabox.dtb \
 	armada-370-netgear-rn102.dtb \
 	armada-370-netgear-rn104.dtb \
-	armada-370-rd.dtb \
-	armada-375-db.dtb \
-	armada-385-db.dtb \
+	armada-370-rd.dtb
+dtb-$(CONFIG_MACH_ARMADA_375) += \
+	armada-375-db.dtb
+dtb-$(CONFIG_MACH_ARMADA_38X) += \
+	armada-385-db.dtb
+dtb-$(CONFIG_MACH_ARMADA_XP) += \
 	armada-xp-axpwifiap.dtb \
 	armada-xp-db.dtb \
 	armada-xp-gp.dtb \
-- 
1.9.0
