From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 16 Mar 2016 15:19:22 +0100
Subject: [PATCH] ARM: dts: sun6i: Add serial0 alias and stdout-path to
 a31s-primo81.dts
Message-ID: <1458137962-27714-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

u-boot uses the kernel as the canonical source for its sunxi dts files
and u-boot needs these.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31s-primo81.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index 68b479b..379746a 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -53,6 +53,14 @@
 / {
 	model = "MSI Primo81 tablet";
 	compatible = "msi,primo81", "allwinner,sun6i-a31s";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
 };
 
 &cpu0 {
-- 
2.7.2
