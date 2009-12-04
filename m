From: eltshanli@gmail.com (Li Jie)
Date: Fri, 4 Dec 2009 19:15:36 +0800
Subject: [PATCH] ARM: NUC900: Fix bug of uart0 platform data
Message-ID: <8fb2581d0912040315g55fb9aa8v1af5eb8e9c0de978@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Wan ZongShun:

nuc900_uart_data lacks of '{}' which causes following errors:

serial8250.0: ttyS0 at MMIO 0xb8000000 (irq = 7) is a 16550
serial8250 serial8250.0: unable to register port at index 1
(IOc018dd60 MEMc01af9b8 IRQ-1014821856): -28
serial8250 serial8250.0: unable to register port at index 2 (IO7 MEM0 IRQ0): -28

Signed-off-by: lijie <eltshanli@gmail.com>
---
 arch/arm/mach-w90x900/cpu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 921cef9..20dc0c9 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -96,6 +96,7 @@ static struct clk_lookup nuc900_clkregs[] = {

 struct plat_serial8250_port nuc900_uart_data[] = {
 	NUC900_8250PORT(UART0),
+	{},
 };

 struct platform_device nuc900_serial_device = {
-- 
1.6.5.3
