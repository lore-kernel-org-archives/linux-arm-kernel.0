From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 18 Jan 2011 12:21:46 -0500
Subject: [PATCH v1 5/5] davinci: da850: remove unused uart pinmux arrays.
In-Reply-To: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
References: <1295371306-24035-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1295371306-24035-6-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850 uart pinmux arrays are not used.  Remove them.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/da850.c              |   15 ---------------
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 ---
 2 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 8927d4a..637274d 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -552,21 +552,6 @@ static const struct mux_config da850_pins[] = {
 #endif
 };
 
-const short da850_uart0_pins[] __initdata = {
-	DA850_NUART0_CTS, DA850_NUART0_RTS, DA850_UART0_RXD, DA850_UART0_TXD,
-	-1
-};
-
-const short da850_uart1_pins[] __initdata = {
-	DA850_UART1_RXD, DA850_UART1_TXD,
-	-1
-};
-
-const short da850_uart2_pins[] __initdata = {
-	DA850_UART2_RXD, DA850_UART2_TXD,
-	-1
-};
-
 const short da850_i2c0_pins[] __initdata = {
 	DA850_I2C0_SDA, DA850_I2C0_SCL,
 	-1
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 18f6c23..cfcb223 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -123,9 +123,6 @@ extern const short da830_ecap2_pins[];
 extern const short da830_eqep0_pins[];
 extern const short da830_eqep1_pins[];
 
-extern const short da850_uart0_pins[];
-extern const short da850_uart1_pins[];
-extern const short da850_uart2_pins[];
 extern const short da850_i2c0_pins[];
 extern const short da850_i2c1_pins[];
 extern const short da850_lcdcntl_pins[];
-- 
1.7.0.4
