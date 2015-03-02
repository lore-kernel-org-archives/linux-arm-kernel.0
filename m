From: jonathar@broadcom.com (Jonathan Richardson)
Date: Mon, 2 Mar 2015 14:41:10 -0800
Subject: [PATCH RESEND 1/1] ARM: dts: Enable Broadcom Cygnus BCM958305K
In-Reply-To: <1425336070-3414-1-git-send-email-jonathar@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
 <1425336070-3414-1-git-send-email-jonathar@broadcom.com>
Message-ID: <1425336070-3414-2-git-send-email-jonathar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT file to enable the Wireless Audio reference design based on the
BCM58305.

Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Tested-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 arch/arm/boot/dts/Makefile       |    3 ++-
 arch/arm/boot/dts/bcm958305k.dts |   53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm958305k.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 91bd5bd..24b6084 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -64,7 +64,8 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 dtb-$(CONFIG_ARCH_BCM_63XX) += bcm963138dvt.dtb
 dtb-$(CONFIG_ARCH_BCM_CYGNUS) += bcm911360_entphn.dtb \
 	bcm911360k.dtb \
-	bcm958300k.dtb
+	bcm958300k.dtb \
+	bcm958305k.dtb
 dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm28155-ap.dtb \
 	bcm21664-garnet.dtb
 dtb-$(CONFIG_ARCH_BERLIN) += \
diff --git a/arch/arm/boot/dts/bcm958305k.dts b/arch/arm/boot/dts/bcm958305k.dts
new file mode 100644
index 0000000..56b429a
--- /dev/null
+++ b/arch/arm/boot/dts/bcm958305k.dts
@@ -0,0 +1,53 @@
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
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/dts-v1/;
+
+#include "bcm-cygnus.dtsi"
+
+/ {
+	model = "Cygnus Wireless Audio (BCM958305K)";
+	compatible = "brcm,bcm58305", "brcm,cygnus";
+
+	aliases {
+		serial0 = &uart3;
+	};
+
+	chosen {
+		stdout-path = &uart3;
+		bootargs = "console=ttyS0,115200";
+	};
+
+	uart3: serial at 18023000 {
+		status = "okay";
+	};
+};
-- 
1.7.9.5
