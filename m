From: venture@google.com (Patrick Venture)
Date: Tue,  4 Sep 2018 08:53:29 -0700
Subject: [PATCH] arm: dts: aspeed: quanta-q71l: Enable adc & ibt nodes
Message-ID: <20180904155329.258447-1-venture@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ADC node is disabled by default in 4.13 tree onward and
needs to be enabled explicitly in separate device trees.

ibt(ipmi-bt-host) node is disabled by default in 4.13 tree onward and
needs to be enabled explicitly in separate device trees.

Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
index c655564e6c6d..385c0f4b69ee 100644
--- a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
@@ -112,6 +112,10 @@
 			&pinctrl_ddcclk_default &pinctrl_ddcdat_default>;
 };
 
+&ibt {
+	status = "okay";
+};
+
 &lpc_snoop {
 	status = "okay";
 	snoop-ports = <0x80>;
@@ -384,6 +388,10 @@
 	status = "okay";
 };
 
+&adc {
+	status = "okay";
+};
+
 &pwm_tacho {
 	status = "okay";
 
-- 
2.19.0.rc1.350.ge57e33dbd1-goog
