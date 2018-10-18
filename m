From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 18 Oct 2018 18:19:13 +0000
Subject: [PATCH V3 1/8] arm64: imx: add imx8qxp support
In-Reply-To: <1539886483-15775-1-git-send-email-aisheng.dong@nxp.com>
References: <1539886483-15775-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1539886483-15775-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX 8QuadXPlus is a quad (4x) Cortex-A35 proccessor. The Cortex-A35
provides full 64-bit ARMv8-A support while maintaining seamless backwards
compatibility with 32-bit ARMv7-A software. Graphics processing is handled
by a dedicated Graphics Processing Unit (GPU) supporting latest graphic APIs.
Video is managed by a dedicated video engine decoding formats, H.265 HEVC
(Main Profile) up to 4K30 and H.264 up to 1080p60, as well as encoding up
to 1080p30. The memory interface supports 32-bit LP-DDR4 without ECC (Error
Correcting Code) protection at 1200 MHz, 40-bit DDR3L with ECC protection at
933 MHz, two FlexSPI , eMMC 5.1, RAW NAND and SD 3.0.

A wide range of peripheral I/Os such as CAN, parallel or MIPI CSI camera
input, Gigabit Ethernet, ADC, USB 2.0 OTG, USB 3.0 and PCIe 3.0 provide
wide flexibility.

More information:
https://www.nxp.com/docs/en/fact-sheet/IMX8XFAMFS.pdf

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v1->v2:
 * update CONFIG option name
---
 arch/arm64/Kconfig.platforms | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 393d2b5..c7324b1 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -139,6 +139,28 @@ config ARCH_MVEBU
 	   - Armada 7K SoC Family
 	   - Armada 8K SoC Family
 
+config ARCH_MXC
+	bool "ARMv8 based NXP i.MX SoC family"
+	select GPIOLIB
+	select PINCTRL
+	select PM
+	select PM_GENERIC_DOMAINS
+	select SOC_BUS
+	help
+	  This enables support for the ARMv8 based SoCs in the
+	  NXP i.MX family.
+
+config SOC_IMX8QXP
+	bool "i.MX8QXP"
+	depends on ARCH_MXC
+	select IMX_MBOX
+	select IMX_SCU
+	select IMX_SCU_PD
+	select MXC_CLK_SCU
+	select PINCTRL_IMX8QXP
+	help
+	  This enables support for NXP i.MX8QXP SoC.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.7.4
