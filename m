From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  8 Aug 2016 21:43:18 +0200
Subject: [PATCH 8/8] ARM: dts: sun8i: Add touchscreen node for sun8i-a33-ga10h
In-Reply-To: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1470685398-14568-8-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ga10h tablet has a gsl3675 touchscreen, add a dt node describing it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
index de6269d..2fea1af 100644
--- a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
+++ b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
@@ -58,6 +58,15 @@
 	status = "okay";
 };
 
+&gsl1680 {
+	compatible = "silead,gsl3675";
+	touchscreen-fw-name = "silead/gsl3675-ga10h.fw";
+	touchscreen-size-x = <1630>;
+	touchscreen-size-y = <990>;
+	touchscreen-inverted-y;
+	status = "okay";
+};
+
 &lradc {
 	button at 600 {
 		label = "Back";
-- 
2.7.4
