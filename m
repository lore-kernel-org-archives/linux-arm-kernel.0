From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 08 Feb 2012 16:40:10 +0000
Subject: [PATCH 13/16] ARM: omap: fix section mismatch warnings in mux.c
 caused by hsmmc.c
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Message-ID: <E1RvAZ0-0006He-RC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous commit causes new section mismatch warnings:

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb30): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_gpio()
The function omap_init_hsmmc() references
the function __init omap_mux_init_gpio().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_gpio is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb4c): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_gpio()
The function omap_init_hsmmc() references
the function __init omap_mux_init_gpio().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_gpio is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb60): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb6c): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb78): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb90): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb9c): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdba8): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdbc0): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdbcc): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdbd8): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdbf8): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc04): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc10): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc28): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc34): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc40): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc58): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc64): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc70): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc7c): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
The function omap_init_hsmmc() references
the function __init omap_mux_init_signal().
This is often because omap_init_hsmmc lacks a __init
annotation or the annotation of omap_mux_init_signal is wrong.

Again, as for omap2_hsmmc_init(), these functions are callable at
runtime via the gpio-twl4030.c driver, and so these can't be marked
__init.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/mux.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index f26b2fa..fb8bc9f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -100,8 +100,8 @@ void omap_mux_write_array(struct omap_mux_partition *partition,
 
 static char *omap_mux_options;
 
-static int __init _omap_mux_init_gpio(struct omap_mux_partition *partition,
-				      int gpio, int val)
+static int _omap_mux_init_gpio(struct omap_mux_partition *partition,
+			       int gpio, int val)
 {
 	struct omap_mux_entry *e;
 	struct omap_mux *gpio_mux = NULL;
@@ -145,7 +145,7 @@ static int __init _omap_mux_init_gpio(struct omap_mux_partition *partition,
 	return 0;
 }
 
-int __init omap_mux_init_gpio(int gpio, int val)
+int omap_mux_init_gpio(int gpio, int val)
 {
 	struct omap_mux_partition *partition;
 	int ret;
@@ -159,9 +159,9 @@ int __init omap_mux_init_gpio(int gpio, int val)
 	return -ENODEV;
 }
 
-static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
-					const char *muxname,
-					struct omap_mux **found_mux)
+static int _omap_mux_get_by_name(struct omap_mux_partition *partition,
+				 const char *muxname,
+				 struct omap_mux **found_mux)
 {
 	struct omap_mux *mux = NULL;
 	struct omap_mux_entry *e;
@@ -240,7 +240,7 @@ omap_mux_get_by_name(const char *muxname,
 	return -ENODEV;
 }
 
-int __init omap_mux_init_signal(const char *muxname, int val)
+int omap_mux_init_signal(const char *muxname, int val)
 {
 	struct omap_mux_partition *partition = NULL;
 	struct omap_mux *mux = NULL;
-- 
1.7.4.4
