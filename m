From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  8 Aug 2016 21:43:14 +0200
Subject: [PATCH 4/8] ARM: dts: sun8i: Add touchscreen node for sun8i-a23-gt90h
In-Reply-To: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1470685398-14568-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gt90h tablet has a gsl3675 touchscreen, add a dt node describing it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
index f27ebbb..da55b5a 100644
--- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
+++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
@@ -53,6 +53,14 @@
 	status = "okay";
 };
 
+&gsl1680 {
+	compatible = "silead,gsl3675";
+	touchscreen-fw-name = "silead/gsl3675-gt90h.fw";
+	touchscreen-size-x = <1792>;
+	touchscreen-size-y = <1024>;
+	status = "okay";
+};
+
 &lradc {
 	button at 600 {
 		label = "Back";
-- 
2.7.4
