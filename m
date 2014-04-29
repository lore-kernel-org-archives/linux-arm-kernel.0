From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 29 Apr 2014 12:03:36 +0200
Subject: [PATCH v5 05/11] ARM: shmobile: r7s72100: genmai: add uart alias and
 activate scif2 as console
In-Reply-To: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
References: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1398765822-2314-6-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We keep the UART naming backwards compatible with the legacy version.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index 941e72ce7c82..ca88458e0706 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -1,7 +1,8 @@
 /*
  * Device Tree Source for the Genmai board
  *
- * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013-14 Renesas Solutions Corp.
+ * Copyright (C) 2014 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -15,6 +16,10 @@
 	model = "Genmai";
 	compatible = "renesas,genmai-reference", "renesas,r7s72100";
 
+	aliases {
+		serial2 = &scif2;
+	};
+
 	chosen {
 		bootargs = "console=ttySC2,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 	};
@@ -48,3 +53,7 @@
 		pagesize = <64>;
 	};
 };
+
+&scif2 {
+	status = "okay";
+};
-- 
1.9.2
