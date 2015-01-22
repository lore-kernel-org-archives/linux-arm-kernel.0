From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 22 Jan 2015 11:21:32 +0000
Subject: [PATCH] arm64: dts: add baud rate to Juno stdout-path
Message-ID: <d0f44fbb7ffc85806ab00d7e54a64161ef79cad7.1421924801.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without explicit command-line parameters, the Juno UART ends up running
at 57600 baud in the kernel, which is at odds with the 115200 baud used
by the rest of the firmware. Since commit 7914a7c5651a5161 now lets us
fix this by specifying default options in stdout-path, do so.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/boot/dts/arm/juno.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index cb3073e..d429129 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -22,7 +22,7 @@
 	};
 
 	chosen {
-		stdout-path = &soc_uart0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	psci {
-- 
1.9.1
