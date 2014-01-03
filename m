From: 21cnbao@gmail.com (Barry Song)
Date: Fri,  3 Jan 2014 10:59:23 +0800
Subject: [PATCH 2/5] ARM: dts: SiRF: add lost usp1_uart_nostreamctrl pin group
 for atlas6
In-Reply-To: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
References: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1388717966-11703-3-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

this patch adds lost usp1_uart_nostreamctrl pin group for atlas6, which
matches with the change in drivers/pinctrl/sirf/pinctrl-atlas6.c.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 978bab4..f289bf1 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -546,6 +546,12 @@
                                                 sirf,function = "usp1";
                                         };
                                 };
+				usp1_uart_nostreamctrl_pins_a: usp1 at 1 {
+                                        usp1 {
+                                                sirf,pins = "usp1_uart_nostreamctrl_grp";
+                                                sirf,function = "usp1_uart_nostreamctrl";
+                                        };
+                                };
                                 usb0_upli_drvbus_pins_a: usb0_upli_drvbus at 0 {
                                         usb0_upli_drvbus {
                                                 sirf,pins = "usb0_upli_drvbusgrp";
-- 
1.7.5.4
