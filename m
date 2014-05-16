From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:30 +0900
Subject: [PATCH 05/12] ARM: shmobile: r7s72100: genmai: add uart alias and
 activate scif2 as console
In-Reply-To: <cover.1400201383.git.horms+renesas@verge.net.au>
References: <cover.1400201383.git.horms+renesas@verge.net.au>
Message-ID: <5be13fefdb83c15ed69eb032dfe011162d1a5269.1400201383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We keep the UART naming backwards compatible with the legacy version.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index 941e72c..ca88458 100644
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
1.8.5.2
