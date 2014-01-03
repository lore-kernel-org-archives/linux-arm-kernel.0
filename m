From: 21cnbao@gmail.com (Barry Song)
Date: Fri,  3 Jan 2014 10:59:26 +0800
Subject: [PATCH 5/5] ARM: dts: SiRF: add pin group for USP0 with only RX or TX
 frame sync
In-Reply-To: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
References: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1388717966-11703-6-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

add pin groups for USP0 only holding one of TX and RX frame sync. this
patch matches with the change in drivers/pinctrl/sirf.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Barry.Song@csr.com>
---
 arch/arm/boot/dts/prima2.dtsi |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index daee5894..e0b8cd6 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -540,6 +540,18 @@
 							"usp0_uart_nostreamctrl";
                                         };
                                 };
+                                usp0_only_utfs_pins_a: usp0 at 2 {
+                                        usp0 {
+                                                sirf,pins = "usp0_only_utfs_grp";
+                                                sirf,function = "usp0_only_utfs";
+                                        };
+                                };
+                                usp0_only_urfs_pins_a: usp0 at 3 {
+                                        usp0 {
+                                                sirf,pins = "usp0_only_urfs_grp";
+                                                sirf,function = "usp0_only_urfs";
+                                        };
+                                };
                                 usp1_pins_a: usp1 at 0 {
                                         usp1 {
                                                 sirf,pins = "usp1grp";
-- 
1.7.5.4
