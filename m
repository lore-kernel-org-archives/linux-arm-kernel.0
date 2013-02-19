From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 19 Feb 2013 14:02:14 +0530
Subject: [PATCH] ARM: davinci: da850 evm: update clock rate for UART 1/2 DT
 nodes
Message-ID: <1361262734-8540-1-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT kernel with latest of denx SPL U-boot boots with garbled UART
logs. This is because in U-boot UART2 gets sourced by PLL0_SYSCLK2
configured for 150MHz. But later in kernel UART2 gets mapped to
PLL1_SYSCLK2 and is configured for 132MHz not for 150MHz.

PLL1 is configured for 264MHz to support mDDR on the EVM. That is
memory controller driving mDDR can be configured for 150MHz and
mDDR it self can operate at 132MHz.

So override UART1 and UART2 DT node clock-frequency property with
rate available on da850 EVM.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/boot/dts/da850-evm.dts |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f712fb6..c359872 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -22,9 +22,11 @@
 			status = "okay";
 		};
 		serial1: serial at 1d0c000 {
+			clock-frequency = <132000000>;
 			status = "okay";
 		};
 		serial2: serial at 1d0d000 {
+			clock-frequency = <132000000>;
 			status = "okay";
 		};
 		rtc0: rtc at 1c23000 {
-- 
1.7.4.1
