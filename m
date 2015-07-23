From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 23 Jul 2015 07:09:33 +0200
Subject: [PATCH] ARM: dts: Use stdout-path in STM32F429 Discovery board
Message-ID: <1437628173-9447-1-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces use of linux,stdout-path by stdout-path as per
"chosen" DT bindings documentation.

Doing that, the "console" argument is no more needed in kernel command
line.

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 8bd3de5..f0b731d 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -53,8 +53,8 @@
 	compatible = "st,stm32f429i-disco", "st,stm32f429";
 
 	chosen {
-		bootargs = "console=ttyS0,115200 root=/dev/ram rdinit=/linuxrc";
-		linux,stdout-path = &usart1;
+		bootargs = "root=/dev/ram rdinit=/linuxrc";
+		stdout-path = "serial0:115200n8";
 	};
 
 	memory {
-- 
1.9.1
