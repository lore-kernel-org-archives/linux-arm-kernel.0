From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  8 Aug 2016 21:43:17 +0200
Subject: [PATCH 7/8] ARM: dts: sun8i: Add touchscreen node for
 sun8i-a23-polaroid-mid2809pxe04
In-Reply-To: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1470685398-14568-7-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node enabling the gsl3670 touchscreen controller found on
sun8i-a23-polaroid-mid2809pxe04 tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
index 6d06e24..70d9339 100644
--- a/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
+++ b/arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
@@ -48,3 +48,11 @@
 	model = "Polaroid MID2809PXE04 tablet";
 	compatible = "polaroid,mid2809pxe04", "allwinner,sun8i-a23";
 };
+
+&gsl1680 {
+	compatible = "silead,gsl3670";
+	touchscreen-fw-name = "silead/gsl3670-polaroid-mid2809pxe04.fw";
+	touchscreen-size-x = <1660>;
+	touchscreen-size-y = <890>;
+	status = "okay";
+};
-- 
2.7.4
