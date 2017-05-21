From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:48:57 +0200
Subject: [PATCH 08/13] ARM: dts: armada-385-linksys: use binary unit prefixes
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-9-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use IEEE 1541-2002 unit prefixes for sizes.

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/boot/dts/armada-385-linksys.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index f1d6b77..4049eaf 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -52,7 +52,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x00000000 0x20000000>; /* 512 MB */
+		reg = <0x00000000 0x20000000>; /* 512 MiB */
 	};
 
 	soc {
@@ -180,50 +180,50 @@
 
 	partition at 0 {
 		label = "u-boot";
-		reg = <0x0000000 0x200000>;  /* 2MB */
+		reg = <0x0000000 0x200000>;  /* 2MiB */
 		read-only;
 	};
 
 	partition at 100000 {
 		label = "u_env";
-		reg = <0x200000 0x40000>;    /* 256KB */
+		reg = <0x200000 0x40000>;    /* 256KiB */
 	};
 
 	partition at 140000 {
 		label = "s_env";
-		reg = <0x240000 0x40000>;    /* 256KB */
+		reg = <0x240000 0x40000>;    /* 256KiB */
 	};
 
 	partition at 900000 {
 		label = "devinfo";
-		reg = <0x900000 0x100000>;   /* 1MB */
+		reg = <0x900000 0x100000>;   /* 1MiB */
 		read-only;
 	};
 
 	/* kernel1 overlaps with rootfs1 by design */
 	partition at a00000 {
 		label = "kernel1";
-		reg = <0xa00000 0x2800000>;  /* 40MB */
+		reg = <0xa00000 0x2800000>;  /* 40MiB */
 	};
 
 	partition at 1000000 {
 		label = "rootfs1";
-		reg = <0x1000000 0x2200000>;  /* 34MB */
+		reg = <0x1000000 0x2200000>;  /* 34MiB */
 	};
 
 	/* kernel2 overlaps with rootfs2 by design */
 	partition at 3200000 {
 		label = "kernel2";
-		reg = <0x3200000 0x2800000>; /* 40MB */
+		reg = <0x3200000 0x2800000>; /* 40MiB */
 	};
 
 	partition at 3800000 {
 		label = "rootfs2";
-		reg = <0x3800000 0x2200000>; /* 34MB */
+		reg = <0x3800000 0x2200000>; /* 34MiB */
 	};
 
 	/*
-	 * 38MB, last MB is for the BBT, not writable
+	 * 38MiB, last MiB is for the BBT, not writable
 	 */
 	partition at 5a00000 {
 		label = "syscfg";
@@ -238,7 +238,7 @@
 	 */
 	partition at 180000 {
 		label = "unused_area";
-		reg = <0x280000 0x680000>;   /* 6.5MB */
+		reg = <0x280000 0x680000>;   /* 6.5MiB */
 	};
 };
 
-- 
2.10.2
