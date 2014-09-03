From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Sep 2014 15:04:39 -0700
Subject: [PATCHv2] ARM: debug: uncompress debug support for omap2plus
In-Reply-To: <20140826075831.GU30401@n2100.arm.linux.org.uk>
References: <1409038140-7433-1-git-send-email-kpark3469@gmail.com>
 <20140826075831.GU30401@n2100.arm.linux.org.uk>
Message-ID: <20140903220433.GQ11766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140826 00:58]:
> On Tue, Aug 26, 2014 at 04:28:59PM +0900, kpark3469 at gmail.com wrote:
> > From: Sahara <keun-o.park@windriver.com>
> > 
> > Since OMAP low-level debug code places data in the .data section,
> > The symbol DEBUG_UNCOMPRESS was defined with !DEBUG_OMAP2PLUS_UART.
> > This patch removes the part using data section in debug/omap2plus.S,
> > so DEBUG_UNCOMPRESS is now available on OMAP system.
> > 
> > Signed-off-by: Sahara <keun-o.park@windriver.com>
> > Tested-by: Afzal Mohammed <afzal.mohd.ma@gmail.com> (on am335x beagle
> > bone white)
> 
> You need to consider whom you are sending this to.  It would be well
> worth including the OMAP maintainer, Tony Lindgren.

Thanks saw it and replied yesterday that we should just rip out
the SoC detection and use standard 8250 debug_ll code.

Regards,

Tony
