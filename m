From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Oct 2011 21:41:30 +0100
Subject: [PATCH v2] mach-ep93xx: break out GPIO driver specifics
In-Reply-To: <20111015181808.GA3128@mwesterb-mobl.ger.corp.intel.com>
References: <1316508132-20020-1-git-send-email-linus.walleij@stericsson.com>
	<20111015181808.GA3128@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <20111015204129.GZ21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 15, 2011 at 09:18:08PM +0300, Mika Westerberg wrote:
> I just tried to compile latest linux-next and due to missing <mach/gpio.h> I
> get:
> 
> In file included from include/linux/gpio.h:18:0,
>                  from drivers/gpio/gpiolib.c:10:
> /home/westeri/devel/kernel/linux/arch/arm/include/asm/gpio.h:5:23: fatal error: mach/gpio.h: No such file or directory
> compilation terminated.
> make[2]: *** [drivers/gpio/gpiolib.o] Error 1
> 
> It looks like arch/arm/include/asm/gpio.h wants to have <mach/gpio.h>. Any idea
> how to fix this?

Hmm.  It shouldn't have been deleted - Linus' patch leaves the file
empty rather than deleting it.

However, as I had to use GNU patch to apply Linus' patch (as git apply
wouldn't because of fuzz), it doesn't understand that, so it removed it.
This is where having an /* empty */ comment avoids that kind of thing,
just like I've done for all the other mach/gpio.h which became empty.
