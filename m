From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Nov 2012 18:13:19 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <1352138600.10947.26.camel@hornet>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <1352138600.10947.26.camel@hornet>
Message-ID: <20121105181319.GB27781@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 06:03:20PM +0000, Pawel Moll wrote:
> On Mon, 2012-11-05 at 17:36 +0000, Will Deacon wrote:
> > I'm inclined to add a dummy VEXPRESS entry to arm/Kconfig which depends on
> > !ARCH_MULTIPLATFORM and just selects ARCH_VEXPRESS (with the if ARCH_MULTI_V7
> > dependency dropped) 
> 
> ... depends on !ARCH_MULTIPLATFORM or maybe rather !MMU? (I assume you
> want to add an extra dummy position in the choice section, where options
> are mutually exclusive anyway?)

Yeah, you could do something like the following but it just feels a bit
nasty:

Will

--->8

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 335e220..0561d87 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -305,6 +305,11 @@ config ARCH_REALVIEW
        help
          This enables support for ARM Ltd RealView boards.
 
+config ARCH_VEXPRESS_NOMMU
+       bool "ARM Ltd. Versatile Express family (nommu)"
+       depends on !MMU
+       select ARCH_VEXPRESS
+
 config ARCH_VERSATILE
        bool "ARM Ltd. Versatile family"
        select ARCH_WANT_OPTIONAL_GPIOLIB
