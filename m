From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 11 Jun 2016 15:53:06 +0200
Subject: [PATCH 6/6] ARM: dts: sun8i-a23-polaroid-mid2809pxe04: Disable ehci0
In-Reply-To: <1465653186-953-1-git-send-email-hdegoede@redhat.com>
References: <1465653186-953-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1465653186-953-7-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Polaroid mid2809pxe04 tablet uses an sdio esp8089 wifi chip, so
ehci0 is not used and should be disabled.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
index bae779f..e8c3f21 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
@@ -72,10 +72,6 @@
 	};
 };
 
-&ehci0 {
-	status = "okay";
-};
-
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
-- 
2.7.4
