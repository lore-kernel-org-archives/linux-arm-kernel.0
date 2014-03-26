From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 26 Mar 2014 11:54:39 -0300
Subject: [PATCH v2 2/2] ARM: dts: imx51-babbage: Add USB OTG support
In-Reply-To: <1395845679-5744-1-git-send-email-festevam@gmail.com>
References: <1395845679-5744-1-git-send-email-festevam@gmail.com>
Message-ID: <1395845679-5744-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Tested by pinging from the host PC to the imx51-babbage via a g_ether 
connection.

Signed-off by: Dave Ebright <dave.ebright@parsons.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Use 'otg' instead of 'peripheral' in the dr_mode property
- use 'utmi_wide' instead of 'utmi'

For USB OTG to work on mx51 the following driver patch is needed:
http://marc.info/?l=linux-usb&m=139571614508749&w=2

 arch/arm/boot/dts/imx51-babbage.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 1084607..4714c08 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -584,3 +584,10 @@
 	phy_type = "ulpi";
 	status = "okay";
 };
+
+&usbotg {
+	dr_mode = "otg";
+	disable-over-current;
+	phy_type = "utmi_wide";
+	status = "okay";
+};
-- 
1.8.1.2
