From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 16 Jan 2013 18:36:12 +0530
Subject: [PATCH 2/2] ARM: tegra: DTS: cardhu: register UARTC
In-Reply-To: <1358341572-8154-1-git-send-email-ldewangan@nvidia.com>
References: <1358341572-8154-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1358341572-8154-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UARTC is used for the interfacing with bluetooth device.
Register this UART channel as high speed serial channel
so that it can use the APB DMA for data transfer.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
The driver file got applied in Greg KH's tty tree.
Tested in linux-next 20121229 with some more changes as
linux-next-20130116 is crashing in pincontrol.

 arch/arm/boot/dts/tegra30-cardhu.dtsi |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index bdb2a66..ff6b68f 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -106,6 +106,15 @@
 				nvidia,slew-rate-rising = <1>;
 				nvidia,slew-rate-falling = <1>;
 			};
+			uart3_txd_pw6 {
+				nvidia,pins =	"uart3_txd_pw6",
+						"uart3_cts_n_pa1",
+						"uart3_rts_n_pc0",
+						"uart3_rxd_pw7";
+				nvidia,function = "uartc";
+				nvidia,pull = <0>;
+				nvidia,tristate = <0>;
+			};
 		};
 	};
 
@@ -114,6 +123,12 @@
 		clock-frequency = <408000000>;
 	};
 
+	serial at 70006200 {
+		compatible = "nvidia,tegra30-hsuart";
+		status = "okay";
+		clock-frequency = <408000000>;
+	};
+
 	i2c at 7000c000 {
 		status = "okay";
 		clock-frequency = <100000>;
-- 
1.7.1.1
