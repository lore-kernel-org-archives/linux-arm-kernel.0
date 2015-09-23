From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Sep 2015 11:34:03 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56027049.7010504@free.fr>
References: <56001B78.2090001@free.fr> <3168184.5li5Yj9y1C@wuerfel>
 <56027049.7010504@free.fr>
Message-ID: <2002438.fvrDoNMsZn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 September 2015 11:26:33 Mason wrote:
> On 22/09/2015 21:15, Arnd Bergmann wrote:
> > On Tuesday 22 September 2015 17:54:04 Mason wrote:
> >> On 22/09/2015 16:51, Arnd Bergmann wrote:
> >>> On Tuesday 22 September 2015 16:36:48 Mason wrote:
> >>>
> >>>> arch/arm/mach-tangox/Kconfig
> >>>> +if ARCH_TANGOX
> >>>> +
> >>>> +config UNCOMPRESS_INCLUDE
> >>>> +	string
> >>>> +	default "debug/uncompress.h"
> >>>
> >>> Better do this like everyone else.
> >>
> >> Do you mean I should provide an empty mach/uncompress.h ?
> > 
> > No, add a debug/*.S file for your uart and do the configuration in
> > arch/arm/Kconfig.debug.
> > 
> > The UNCOMPRESS_INCLUDE symbol is defined in arch/arm/Kconfig.debug,
> > and you should not duplicate that.
> 
> config UNCOMPRESS_INCLUDE
> 	string
> 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
> 					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M || \
> 					ARCH_SHMOBILE_LEGACY
> 	default "mach/uncompress.h"
> 
> 
> I'm going for the smallest possible port, I don't have a debug/tango.S
> I didn't define DEBUG_UNCOMPRESS in my .config, and I just wanted to
> get this NOP definition from debug/uncompress.h
> 
> 	static inline void putc(int c) {}
> 
> Are you saying I cannot do it like that?
> 
> If ARCH_MULTIPLATFORM is defined, then debug/uncompress.h will be
> included, just like I want.
> 
> If ARCH_MULTIPLATFORM is not defined, can I do this in my port:
> 
> config UNCOMPRESS_INCLUDE
> 	string
> 	default "debug/uncompress.h" if !ARCH_MULTIPLATFORM
> 
> or add my platform to the list on arch/arm/Kconfig.debug?

Just use ARCH_MULTIPLATFORM.

	Arnd
