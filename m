From: jonmason@broadcom.com (Jon Mason)
Date: Thu, 15 Oct 2015 18:24:16 -0400
Subject: [PATCH v3 2/2] ARM: dts: bcm5301x: Add BCM SVK DT files
In-Reply-To: <1444947856-26246-1-git-send-email-jonmason@broadcom.com>
References: <1444947856-26246-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1444947856-26246-2-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree files for Broadcom Northstar based SVKs.  Since the
bcm5301x.dtsi already exists, all that is necessary is the dts files to
enable the UARTs.  With these files, the SVKs are able to boot to shell.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/Makefile       |  5 +++-
 arch/arm/boot/dts/bcm94708.dts   | 56 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm94709.dts   | 56 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm953012k.dts | 63 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm94708.dts
 create mode 100644 arch/arm/boot/dts/bcm94709.dts
 create mode 100644 arch/arm/boot/dts/bcm953012k.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 233159d..96a1b58 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -72,7 +72,10 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm47081-buffalo-wzr-900dhp.dtb \
 	bcm4709-asus-rt-ac87u.dtb \
 	bcm4709-buffalo-wxr-1900dhp.dtb \
-	bcm4709-netgear-r8000.dtb
+	bcm4709-netgear-r8000.dtb \
+	bcm94708.dtb \
+	bcm94709.dtb \
+	bcm953012k.dtb
 dtb-$(CONFIG_ARCH_BCM_63XX) += \
 	bcm963138dvt.dtb
 dtb-$(CONFIG_ARCH_BCM_CYGNUS) += \
diff --git a/arch/arm/boot/dts/bcm94708.dts b/arch/arm/boot/dts/bcm94708.dts
new file mode 100644
index 0000000..49682d6
--- /dev/null
+++ b/arch/arm/boot/dts/bcm94708.dts
@@ -0,0 +1,56 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Broadcom Corporation nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+
+/ {
+	model = "NorthStar SVK (BCM94708)";
+	compatible = "brcm,bcm94708", "brcm,bcm4708";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm94709.dts b/arch/arm/boot/dts/bcm94709.dts
new file mode 100644
index 0000000..4ab19c0
--- /dev/null
+++ b/arch/arm/boot/dts/bcm94709.dts
@@ -0,0 +1,56 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Broadcom Corporation nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+
+/ {
+	model = "NorthStar SVK (BCM94709)";
+	compatible = "brcm,bcm94709", "brcm,bcm4709", "brcm,bcm4708";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/bcm953012k.dts
new file mode 100644
index 0000000..a512c45
--- /dev/null
+++ b/arch/arm/boot/dts/bcm953012k.dts
@@ -0,0 +1,63 @@
+/*
+ *  BSD LICENSE
+ *
+ *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
+ *
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *
+ *    * Redistributions of source code must retain the above copyright
+ *      notice, this list of conditions and the following disclaimer.
+ *    * Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in
+ *      the documentation and/or other materials provided with the
+ *      distribution.
+ *    * Neither the name of Broadcom Corporation nor the names of its
+ *      contributors may be used to endorse or promote products derived
+ *      from this software without specific prior written permission.
+ *
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+
+/ {
+	model = "NorthStar SVK (BCM953012K)";
+	compatible = "brcm,bcm953012k", "brcm,brcm53012", "brcm,bcm4708";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		reg = <0x00000000 0x10000000>;
+	};
+};
+
+&uart0 {
+	clock-frequency = <62499840>;
+	status = "okay";
+};
+
+&uart1 {
+	clock-frequency = <62499840>;
+	status = "okay";
+};
-- 
1.9.1
