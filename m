From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 13:58:45 +0800
Subject: [Patch v2 11/14] ARM: dts: imx6: Add disconnect-line-without-vbus
 property for usbphy
In-Reply-To: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382421528-17897-12-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the vbus is not there and the PHY is out of power, we need to
disconnect connection between USB PHY and USB controller, otherwise
the unexpected USB wakeup will occur due to dp/dm change at device
mode.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 145ece2..89eeda7 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -542,6 +542,7 @@
 				interrupts = <0 44 0x04>;
 				clocks = <&clks 182>;
 				fsl,anatop = <&anatop>;
+				disconnect-line-without-vbus;
 			};
 
 			usbphy2: usbphy at 020ca000 {
-- 
1.7.1
