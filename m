From: ijc@hellion.org.uk (Ian Campbell)
Date: Fri, 24 Jan 2014 14:14:12 +0000
Subject: [PATCH] sunxi: dts: add a note that memory size is adjusted by boot
 loader.
Message-ID: <1390572852-15027-1-git-send-email-ijc@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I had to spend a couple of minutes proving to myself that this was the case on
cubietruck, so add a comment to save the next guy some effort.

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-sunxi at googlegroups.com
---
This patch applies cleanly against v3.13 and Hans' sunxi-devel branch.

A plausible alternative would be to pull the memory node out of the dtsi files
and into the board specific files. I didn't go straight to that since I'd have
to research all the various boards ;-)

I considered maing it "reg = <0 0>" but decided that having some sort of least
common denominator would let things work even if the bootloader were broken.
---
 arch/arm/boot/dts/sun4i-a10.dtsi  |    1 +
 arch/arm/boot/dts/sun5i-a10s.dtsi |    1 +
 arch/arm/boot/dts/sun5i-a13.dtsi  |    1 +
 arch/arm/boot/dts/sun6i-a31.dtsi  |    1 +
 arch/arm/boot/dts/sun7i-a20.dtsi  |    1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 3e60883..9ba0beb 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -30,6 +30,7 @@
 	};
 
 	memory {
+		/* 1GB by default, will be updated by U-Boot */
 		reg = <0x40000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 0376c50..d12ed7e 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -27,6 +27,7 @@
 	};
 
 	memory {
+		/* 512MB by default, will be updated by U-Boot */
 		reg = <0x40000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index b81aeb9..6f8bfd9 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -27,6 +27,7 @@
 	};
 
 	memory {
+		/* 512MB by default, will be updated by U-Boot */
 		reg = <0x40000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 3f6f07b..bcbef9a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -46,6 +46,7 @@
 	};
 
 	memory {
+		/* 2GB by default, will be updated by U-Boot */
 		reg = <0x40000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 907cfcc..658e74b 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -38,6 +38,7 @@
 	};
 
 	memory {
+		/* 1GB by default, will be updated by U-Boot */
 		reg = <0x40000000 0x80000000>;
 	};
 
-- 
1.7.10.4
