From: stefan@agner.ch (Stefan Agner)
Date: Sun, 12 Oct 2014 20:14:01 +0200
Subject: [RFC 7/7] ARM: vf610m4: add defconfig for Linux on Vybrids Cortex-M4
In-Reply-To: <cover.1413136383.git.stefan@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
Message-ID: <38ccdff89b72ed42a4e048b5446debf06d17ae57.1413136383.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add defconfig for Linux on Vybrid (vf610) on the secondary Cortex-
M4 CPU. Currently, we use a XIP image which is loaded to the end
of RAM at 0x8f000000. DRAM base address is at 0x88000000.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/vf610m4_defconfig | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 arch/arm/configs/vf610m4_defconfig

diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
new file mode 100644
index 0000000..90c5a6c
--- /dev/null
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -0,0 +1,37 @@
+CONFIG_NAMESPACES=y
+# CONFIG_SGETMASK_SYSCALL is not set
+CONFIG_EMBEDDED=y
+# CONFIG_SECCOMP is not set
+CONFIG_HZ_100=y
+# CONFIG_SUSPEND is not set
+# CONFIG_UEVENT_HELPER is not set
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_SRAM=y
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_GPIO_POLLED=y
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+CONFIG_SERIAL_NONSTANDARD=y
+CONFIG_SERIAL_FSL_LPUART=y
+CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_GPIOLIB=y
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT3_FS=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_LOCKUP_DETECTOR=y
+# CONFIG_FTRACE is not set
+# CONFIG_VIRTUALIZATION is not set
-- 
2.1.2
