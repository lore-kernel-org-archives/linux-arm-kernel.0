From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  5 Oct 2013 16:17:56 +0200
Subject: [PATCH 4/4] Documentation: dt: Remove clock gates IDs list for
 Allwinner SoCs
In-Reply-To: <1380982676-10055-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1380982676-10055-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1380982676-10055-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That documentation was mostly useful when we didn't have any
documentation for those SoCs, which is not the case anymore. Remove
this, since it should live in the DT anyway.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/clock/sunxi.txt  |  4 +-
 .../bindings/clock/sunxi/sun4i-a10-gates.txt       | 93 --------------------
 .../bindings/clock/sunxi/sun5i-a10s-gates.txt      | 75 -----------------
 .../bindings/clock/sunxi/sun5i-a13-gates.txt       | 58 -------------
 .../bindings/clock/sunxi/sun6i-a31-gates.txt       | 83 ------------------
 .../bindings/clock/sunxi/sun7i-a20-gates.txt       | 98 ----------------------
 6 files changed, 2 insertions(+), 409 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun4i-a10-gates.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun5i-a10s-gates.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun5i-a13-gates.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun6i-a31-gates.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi/sun7i-a20-gates.txt

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 00a5c264..91a748f 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -45,8 +45,8 @@ Additionally, "allwinner,*-gates-clk" clocks require:
 
 Clock consumers should specify the desired clocks they use with a
 "clocks" phandle cell. Consumers that are using a gated clock should
-provide an additional ID in their clock property. The values of this
-ID are documented in sunxi/<soc>-gates.txt.
+provide an additional ID in their clock property. This ID is the
+offset of the bit controlling this particular gate in the register.
 
 For example:
 
diff --git a/Documentation/devicetree/bindings/clock/sunxi/sun4i-a10-gates.txt b/Documentation/devicetree/bindings/clock/sunxi/sun4i-a10-gates.txt
deleted file mode 100644
index 6a03475..0000000
--- a/Documentation/devicetree/bindings/clock/sunxi/sun4i-a10-gates.txt
+++ /dev/null
@@ -1,93 +0,0 @@
-Gate clock outputs
-------------------
-
-  * AXI gates ("allwinner,sun4i-axi-gates-clk")
-
-    DRAM					0
-
-  * AHB gates ("allwinner,sun4i-ahb-gates-clk")
-
-    USB0					0
-    EHCI0					1
-    OHCI0					2*
-    EHCI1					3
-    OHCI1					4*
-    SS						5
-    DMA						6
-    BIST					7
-    MMC0					8
-    MMC1					9
-    MMC2					10
-    MMC3					11
-    MS						12**
-    NAND					13
-    SDRAM					14
-
-    ACE						16
-    EMAC					17
-    TS						18
-
-    SPI0					20
-    SPI1					21
-    SPI2					22
-    SPI3					23
-    PATA					24
-    SATA					25**
-    GPS						26*
-
-    VE						32
-    TVD						33
-    TVE0					34
-    TVE1					35
-    LCD0					36
-    LCD1					37
-
-    CSI0					40
-    CSI1					41
-
-    HDMI					43
-    DE_BE0					44
-    DE_BE1					45
-    DE_FE1					46
-    DE_FE1					47
-
-    MP						50
-
-    MALI400					52
-
-  * APB0 gates ("allwinner,sun4i-apb0-gates-clk")
-
-    CODEC					0
-    SPDIF					1*
-    AC97					2
-    IIS						3
-
-    PIO						5
-    IR0						6
-    IR1						7
-
-    KEYPAD					10
-
-  * APB1 gates ("allwinner,sun4i-apb1-gates-clk")
-
-    I2C0					0
-    I2C1					1
-    I2C2					2
-
-    CAN						4
-    SCR						5
-    PS20					6
-    PS21					7
-
-    UART0					16
-    UART1					17
-    UART2					18
-    UART3					19
-    UART4					20
-    UART5					21
-    UART6					22
-    UART7					23
-
-Notation:
- [*]:  The datasheet didn't mention these, but they are present on AW code
- [**]: The datasheet had this marked as "NC" but they are used on AW code
diff --git a/Documentation/devicetree/bindings/clock/sunxi/sun5i-a10s-gates.txt b/Documentation/devicetree/bindings/clock/sunxi/sun5i-a10s-gates.txt
deleted file mode 100644
index d24279f..0000000
--- a/Documentation/devicetree/bindings/clock/sunxi/sun5i-a10s-gates.txt
+++ /dev/null
@@ -1,75 +0,0 @@
-Gate clock outputs
-------------------
-
-  * AXI gates ("allwinner,sun4i-axi-gates-clk")
-
-    DRAM					0
-
-  * AHB gates ("allwinner,sun5i-a10s-ahb-gates-clk")
-
-    USB0					0
-    EHCI0					1
-    OHCI0					2
-
-    SS						5
-    DMA						6
-    BIST					7
-    MMC0					8
-    MMC1					9
-    MMC2					10
-
-    NAND					13
-    SDRAM					14
-
-    EMAC					17
-    TS						18
-
-    SPI0					20
-    SPI1					21
-    SPI2					22
-
-    GPS						26
-
-    HSTIMER					28
-
-    VE						32
-
-    TVE						34
-
-    LCD						36
-
-    CSI						40
-
-    HDMI					43
-    DE_BE					44
-
-    DE_FE					46
-
-    IEP						51
-    MALI400					52
-
-  * APB0 gates ("allwinner,sun5i-a10s-apb0-gates-clk")
-
-    CODEC					0
-
-    IIS						3
-
-    PIO						5
-    IR						6
-
-    KEYPAD					10
-
-  * APB1 gates ("allwinner,sun5i-a10s-apb1-gates-clk")
-
-    I2C0					0
-    I2C1					1
-    I2C2					2
-
-    UART0					16
-    UART1					17
-    UART2					18
-    UART3					19
-
-Notation:
- [*]:  The datasheet didn't mention these, but they are present on AW code
- [**]: The datasheet had this marked as "NC" but they are used on AW code
diff --git a/Documentation/devicetree/bindings/clock/sunxi/sun5i-a13-gates.txt b/Documentation/devicetree/bindings/clock/sunxi/sun5i-a13-gates.txt
deleted file mode 100644
index 006b6df..0000000
--- a/Documentation/devicetree/bindings/clock/sunxi/sun5i-a13-gates.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-Gate clock outputs
-------------------
-
-  * AXI gates ("allwinner,sun4i-axi-gates-clk")
-
-    DRAM					0
-
-  * AHB gates ("allwinner,sun5i-a13-ahb-gates-clk")
-
-    USBOTG					0
-    EHCI					1
-    OHCI					2
-
-    SS						5
-    DMA						6
-    BIST					7
-    MMC0					8
-    MMC1					9
-    MMC2					10
-
-    NAND					13
-    SDRAM					14
-
-    SPI0					20
-    SPI1					21
-    SPI2					22
-
-    STIMER					28
-
-    VE						32
-
-    LCD						36
-
-    CSI						40
-
-    DE_BE					44
-
-    DE_FE					46
-
-    IEP						51
-    MALI400					52
-
-  * APB0 gates ("allwinner,sun5i-a13-apb0-gates-clk")
-
-    CODEC					0
-
-    PIO						5
-    IR						6
-
-  * APB1 gates ("allwinner,sun5i-a13-apb1-gates-clk")
-
-    I2C0					0
-    I2C1					1
-    I2C2					2
-
-    UART1					17
-
-    UART3					19
diff --git a/Documentation/devicetree/bindings/clock/sunxi/sun6i-a31-gates.txt b/Documentation/devicetree/bindings/clock/sunxi/sun6i-a31-gates.txt
deleted file mode 100644
index fe44932..0000000
--- a/Documentation/devicetree/bindings/clock/sunxi/sun6i-a31-gates.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-Gate clock outputs
-------------------
-
-  * AHB1 gates ("allwinner,sun6i-a31-ahb1-gates-clk")
-
-    MIPI DSI					1
-
-    SS						5
-    DMA						6
-
-    MMC0					8
-    MMC1					9
-    MMC2					10
-    MMC3					11
-
-    NAND1					12
-    NAND0					13
-    SDRAM					14
-
-    GMAC					17
-    TS						18
-    HSTIMER					19
-    SPI0					20
-    SPI1					21
-    SPI2					22
-    SPI3					23
-    USB_OTG					24
-
-    EHCI0					26
-    EHCI1					27
-
-    OHCI0					29
-    OHCI1					30
-    OHCI2					31
-    VE						32
-
-    LCD0					36
-    LCD1					37
-
-    CSI						40
-
-    HDMI					43
-    DE_BE0					44
-    DE_BE1					45
-    DE_FE1					46
-    DE_FE1					47
-
-    MP						50
-
-    GPU						52
-
-    DEU0					55
-    DEU1					56
-    DRC0					57
-    DRC1					58
-
-  * APB1 gates ("allwinner,sun6i-a31-apb1-gates-clk")
-
-    CODEC					0
-
-    DIGITAL MIC					4
-    PIO						5
-
-    DAUDIO0					12
-    DAUDIO1					13
-
-  * APB2 gates ("allwinner,sun6i-a31-apb2-gates-clk")
-
-    I2C0					0
-    I2C1					1
-    I2C2					2
-    I2C3					3
-
-    UART0					16
-    UART1					17
-    UART2					18
-    UART3					19
-    UART4					20
-    UART5					21
-
-Notation:
- [*]:  The datasheet didn't mention these, but they are present on AW code
- [**]: The datasheet had this marked as "NC" but they are used on AW code
diff --git a/Documentation/devicetree/bindings/clock/sunxi/sun7i-a20-gates.txt b/Documentation/devicetree/bindings/clock/sunxi/sun7i-a20-gates.txt
deleted file mode 100644
index 357f4fd..0000000
--- a/Documentation/devicetree/bindings/clock/sunxi/sun7i-a20-gates.txt
+++ /dev/null
@@ -1,98 +0,0 @@
-Gate clock outputs
-------------------
-
-  * AXI gates ("allwinner,sun4i-axi-gates-clk")
-
-    DRAM					0
-
-  * AHB gates ("allwinner,sun7i-a20-ahb-gates-clk")
-
-    USB0					0
-    EHCI0					1
-    OHCI0					2
-    EHCI1					3
-    OHCI1					4
-    SS						5
-    DMA						6
-    BIST					7
-    MMC0					8
-    MMC1					9
-    MMC2					10
-    MMC3					11
-    MS						12
-    NAND					13
-    SDRAM					14
-
-    ACE						16
-    EMAC					17
-    TS						18
-
-    SPI0					20
-    SPI1					21
-    SPI2					22
-    SPI3					23
-
-    SATA					25
-
-    HSTIMER					28
-
-    VE						32
-    TVD						33
-    TVE0					34
-    TVE1					35
-    LCD0					36
-    LCD1					37
-
-    CSI0					40
-    CSI1					41
-
-    HDMI1					42
-    HDMI0					43
-    DE_BE0					44
-    DE_BE1					45
-    DE_FE1					46
-    DE_FE1					47
-
-    GMAC					49
-    MP						50
-
-    MALI400					52
-
-  * APB0 gates ("allwinner,sun7i-a20-apb0-gates-clk")
-
-    CODEC					0
-    SPDIF					1
-    AC97					2
-    IIS0					3
-    IIS1					4
-    PIO						5
-    IR0						6
-    IR1						7
-    IIS2					8
-
-    KEYPAD					10
-
-  * APB1 gates ("allwinner,sun7i-a20-apb1-gates-clk")
-
-    I2C0					0
-    I2C1					1
-    I2C2					2
-    I2C3					3
-    CAN						4
-    SCR						5
-    PS20					6
-    PS21					7
-
-    I2C4					15
-    UART0					16
-    UART1					17
-    UART2					18
-    UART3					19
-    UART4					20
-    UART5					21
-    UART6					22
-    UART7					23
-
-Notation:
- [*]:  The datasheet didn't mention these, but they are present on AW code
- [**]: The datasheet had this marked as "NC" but they are used on AW code
-- 
1.8.4
