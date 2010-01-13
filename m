From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 13 Jan 2010 13:11:49 -0500
Subject: [PATCH] ARM: Fix uncompress code compile for different definesof
	static(void)
In-Reply-To: <20100113084937.GA19352@pengutronix.de>
References: <20100113021939.GE2986@atomide.com>
	<20100113084937.GA19352@pengutronix.de>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089C39@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 13, 2010 1:50 AM, Uwe Kleine-K?nig wrote:
>> Also use a static inline function instead of define
>> for mach-mxc and mach-gemini to avoid similar bug
>> for those platforms.
> As arch/arm/boot/compressed/misc.c is compiled with -Dstatic= and this
> is AFAIK the only user of uncompress.h I'd skip "static" and/or add a
> comment telling that static is redundant here.

So that's what causes the sparse warning!

Compiling misc.c produces a bunch of sparse warnings to the type:

arch/arm/boot/compressed/misc.c:19:14: warning: symbol '__machine_arch_type' was not declared. Should it be static?
arch/arm/mach-ep93xx/include/mach/uncompress.h:75:13: warning: symbol 'ethernet_reset' was not declared. Should it be static?
arch/arm/mach-ep93xx/include/mach/uncompress.h:109:13: warning: symbol 'enable_early_uart' was not declared. Should it be static?
arch/arm/mach-ep93xx/include/mach/uncompress.h:152:13: warning: symbol 'arch_decomp_setup' was not declared. Should it be static?
arch/arm/boot/compressed/misc.c:201:12: warning: symbol 'inbuf' was not declared. Should it be static?
arch/arm/boot/compressed/misc.c:202:12: warning: symbol 'window' was not declared. Should it be static?
arch/arm/boot/compressed/misc.c:204:17: warning: symbol 'insize' was not declared. Should it be static?
arch/arm/boot/compressed/misc.c:205:17: warning: symbol 'inptr' was not declared. Should it be static?
arch/arm/boot/compressed/misc.c:206:17: warning: symbol 'outcnt' was not declared. Should it be static?

Etc..

Any ideas on how to suppress the warnings?

Regards,
Hartley
