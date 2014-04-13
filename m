From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 13 Apr 2014 13:41:02 +0200
Subject: [PATCH 1/4] ARM: sun6i: dt: Fixup prcm node name
In-Reply-To: <1397389265-22288-1-git-send-email-hdegoede@redhat.com>
References: <1397389265-22288-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1397389265-22288-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The prcm lives at address 0x01f01400 as the reg entry in its node already
correctly indicates, rename the node to match this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 8df8947..ba08574c 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -490,14 +490,14 @@
 			interrupts = <1 9 0xf04>;
 		};
 
+		prcm at 01f01400 {
+			compatible = "allwinner,sun6i-a31-prcm";
+			reg = <0x01f01400 0x200>;
+		};
+
 		cpucfg at 01f01c00 {
 			compatible = "allwinner,sun6i-a31-cpuconfig";
 			reg = <0x01f01c00 0x300>;
 		};
-
-		prcm at 01f01c00 {
-			compatible = "allwinner,sun6i-a31-prcm";
-			reg = <0x01f01400 0x200>;
-		};
 	};
 };
-- 
1.9.0
