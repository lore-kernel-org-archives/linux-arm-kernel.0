From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 20 Jun 2015 17:40:10 +0200
Subject: [PATCH 4/4] ARM: dts: sun6i: Enable otg controller on the cs908
In-Reply-To: <1434814810-26285-1-git-send-email-hdegoede@redhat.com>
References: <1434814810-26285-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1434814810-26285-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cs908 has the otg controller connected to one of the 2 usb-A
receptacles it has on the front, so enable the otg controller in host-only
mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31s-cs908.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-cs908.dts b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
index 1e2411a..5e8f8c4 100644
--- a/arch/arm/boot/dts/sun6i-a31s-cs908.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
@@ -93,6 +93,11 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usbphy {
 	status = "okay";
 };
-- 
2.4.3
