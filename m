From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Mon, 25 Jan 2016 11:01:21 +0800
Subject: [PATCH v7 4/6] ARM: debug: add hi3519 debug uart
In-Reply-To: <1453690883-31220-1-git-send-email-xuejiancheng@huawei.com>
References: <1453690883-31220-1-git-send-email-xuejiancheng@huawei.com>
Message-ID: <1453690883-31220-5-git-send-email-xuejiancheng@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add hi3519 debug uart

Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c6b6175..b02a7c1 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -260,6 +260,14 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Cortina Gemini based platforms.
 
+	config DEBUG_HI3519_UART
+		bool "Hisilicon HI3519 Debug UART"
+		depends on ARCH_HISI
+		select DEBUG_UART_PL01X
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on HI3519 UART.
+
 	config DEBUG_HI3620_UART
 		bool "Hisilicon HI3620 Debug UART"
 		depends on ARCH_HI3xxx
@@ -1451,6 +1459,7 @@ config DEBUG_UART_PHYS
 	default 0x11002000 if DEBUG_MT8127_UART0
 	default 0x11006000 if DEBUG_MT6589_UART0
 	default 0x11009000 if DEBUG_MT8135_UART3
+	default 0x12100000 if DEBUG_HI3519_UART
 	default 0x16000000 if DEBUG_INTEGRATOR
 	default 0x18000300 if DEBUG_BCM_5301X
 	default 0x18010000 if DEBUG_SIRFATLAS7_UART0
@@ -1514,6 +1523,7 @@ config DEBUG_UART_PHYS
 	default 0xfcb00000 if DEBUG_HI3620_UART
 	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfe800000 if ARCH_IOP32X
+	default 0xfef00000 if DEBUG_HI3519_UART
 	default 0xff690000 if DEBUG_RK32_UART2
 	default 0xffc02000 if DEBUG_SOCFPGA_UART0
 	default 0xffc02100 if DEBUG_SOCFPGA_UART1
-- 
1.9.1
