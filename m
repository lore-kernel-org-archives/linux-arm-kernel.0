From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 21 Feb 2011 22:53:04 +0300
Subject: [PATCH 1/2] PRUSS UIO driver support
In-Reply-To: <20110221193316.GC2773@local>
References: <1298041530-26855-1-git-send-email-pratheesh@ti.com>	<201102181644.17634.arnd@arndb.de>	<alpine.LFD.2.00.1102181713480.2701@localhost6.localdomain6>	<201102181731.05644.arnd@arndb.de>	<alpine.LFD.2.00.1102181802580.2701@localhost6.localdomain6>	<B85A65D85D7EB246BE421B3FB0FBB593024B83C108@dbde02.ent.ti.com>	<20110219183427.GG4684@local>	<B85A65D85D7EB246BE421B3FB0FBB593024B83C20F@dbde02.ent.ti.com>
	<20110221193316.GC2773@local>
Message-ID: <4D62C2A0.6060405@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Hans J. Koch wrote:

>>> -----Original Message-----
>>> From: Hans J. Koch [mailto:hjk at hansjkoch.de]
>>> Sent: Sunday, February 20, 2011 12:04 AM
>>> To: TK, Pratheesh Gangadhar
>>> Cc: Thomas Gleixner; Arnd Bergmann; linux-arm-kernel at lists.infradead.org;
>>> davinci-linux-open-source at linux.davincidsp.com; gregkh at suse.de;
>>> Chatterjee, Amit; Hans J. Koch; LKML
>>> Subject: Re: [PATCH 1/2] PRUSS UIO driver support

>>> On Sat, Feb 19, 2011 at 09:10:23PM +0530, TK, Pratheesh Gangadhar wrote:
>>>> For my understanding - if the interrupt is not shared and not level triggered -
>>>> is this okay to have empty handler?

>>> Greg already said he won't accept that. And I'm quite sure these
>>> interrupts
>>> are level triggered, since that is the default on arch/omap.

>>> E.g. in arch/arm/mach-omap1/irq.c, a loop sets all irqs to level triggered
>>> handling: set_irq_handler(j, handle_level_irq); (line 234)

>> You should be looking at arch/arm/mach-davinci/irq.c

    Into arch/arm/mach-davinci/cp_intc.c actually as we're not talking about a 
"real" DaVincis here, but about OMAP-L138.

> Hmpf. I alway get lost in the directory structure of TI SoCs...
> At least I learned that OMAP3 is in the omap2 directory :)

    It's probably even more convoluted with DaVinci and friends. :-)

>> and all interrupts except IRQ_TINT1_TINT34 is set to edge trigger mode (line 160).

> Is that really needed? Level triggered interrupts should certainly be
> preferred if possible.

    Don't look there, this code is for "real" DaVincis only.

> Thanks,
> Hans

WBR, Sergei
