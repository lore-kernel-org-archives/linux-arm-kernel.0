From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  4 Jan 2017 12:05:27 +0000
Subject: [PATCH] mailbox: sti: Fix mbox-names copy and paste error
Message-ID: <20170104120527.24806-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to an over-sight, mbox-names has become mbox-name in some instances.

Let's put it right.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt | 4 ++--
 arch/arm/boot/dts/stih407-family.dtsi                     | 8 ++++----
 drivers/mailbox/mailbox-sti.c                             | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
index 351f612..648d176 100644
--- a/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
@@ -9,7 +9,7 @@ Controller
 Required properties:
 - compatible		: Should be "st,stih407-mailbox"
 - reg			: Offset and length of the device's register set
-- mbox-name		: Name of the mailbox
+- mbox-names		: Name of the mailbox
 - #mbox-cells:		: Must be 2
 			  <&phandle instance channel direction>
 			    phandle   : Label name of controller
@@ -26,7 +26,7 @@ mailbox0: mailbox at 0  {
 	reg		= <0x08f00000 0x1000>;
 	interrupts	= <GIC_SPI 1 IRQ_TYPE_NONE>;
 	#mbox-cells	= <2>;
-	mbox-name	= "a9";
+	mbox-names	= "a9";
 };
 
 Client
diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index c8b2944..00c67d4 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -787,7 +787,7 @@
 			reg		= <0x8f00000 0x1000>;
 			interrupts	= <GIC_SPI 1 IRQ_TYPE_NONE>;
 			#mbox-cells	= <2>;
-			mbox-name	= "a9";
+			mbox-names	= "a9";
 			status		= "okay";
 		};
 
@@ -795,7 +795,7 @@
 			compatible	= "st,stih407-mailbox";
 			reg		= <0x8f01000 0x1000>;
 			#mbox-cells	= <2>;
-			mbox-name	= "st231_gp_1";
+			mbox-names	= "st231_gp_1";
 			status		= "okay";
 		};
 
@@ -803,7 +803,7 @@
 			compatible	= "st,stih407-mailbox";
 			reg		= <0x8f02000 0x1000>;
 			#mbox-cells	= <2>;
-			mbox-name	= "st231_gp_0";
+			mbox-names	= "st231_gp_0";
 			status		= "okay";
 		};
 
@@ -811,7 +811,7 @@
 			compatible	= "st,stih407-mailbox";
 			reg		= <0x8f03000 0x1000>;
 			#mbox-cells	= <2>;
-			mbox-name	= "st231_audio_video";
+			mbox-names	= "st231_audio_video";
 			status		= "okay";
 		};
 
diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
index 41bcd33..e532a98 100644
--- a/drivers/mailbox/mailbox-sti.c
+++ b/drivers/mailbox/mailbox-sti.c
@@ -434,7 +434,7 @@ static int sti_mbox_probe(struct platform_device *pdev)
 	if (IS_ERR(mdev->base))
 		return PTR_ERR(mdev->base);
 
-	ret = of_property_read_string(np, "mbox-name", &mdev->name);
+	ret = of_property_read_string(np, "mbox-names", &mdev->name);
 	if (ret)
 		mdev->name = np->full_name;
 
-- 
2.10.2
