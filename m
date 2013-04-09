From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Apr 2013 23:26:18 +0200
Subject: [PATCHv1 5/5] ARM: mvebu: do not duplicate the mpic alias
In-Reply-To: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1365542778-27959-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mpic alias is already defined in the common armada-370-xp.dtsi, so
there's no need to repeat it at the armada-xp.dtsi and armada-370.dtsi
level.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi |    2 +-
 arch/arm/boot/dts/armada-xp.dtsi  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index a195deb..cede6a4 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -33,7 +33,7 @@
 		gpio2 = &gpio2;
 	};
 
-	mpic: interrupt-controller at d0020000 {
+	interrupt-controller at d0020000 {
 	      reg = <0xd0020a00 0x1d0>,
 		    <0xd0021870 0x58>;
 	};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index ca00d83..2fed73b 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -29,7 +29,7 @@
 		wt-override;
 	};
 
-	mpic: interrupt-controller at d0020000 {
+	interrupt-controller at d0020000 {
 	      reg = <0xd0020a00 0x2d0>,
 		    <0xd0021070 0x58>;
 	};
-- 
1.7.9.5
