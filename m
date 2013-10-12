From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 12 Oct 2013 17:09:46 +0800
Subject: [PATCH 12/12] ARM: dts: imx6: Add disconnect_line_without_vbus
 property for usbphy
In-Reply-To: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1381568986-19802-13-git-send-email-peter.chen@freescale.com>
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
index 145ece2..b95ab40 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -542,6 +542,7 @@
 				interrupts = <0 44 0x04>;
 				clocks = <&clks 182>;
 				fsl,anatop = <&anatop>;
+				disconnect_line_without_vbus;
 			};
 
 			usbphy2: usbphy at 020ca000 {
-- 
1.7.1
