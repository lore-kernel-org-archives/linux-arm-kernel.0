From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Feb 2011 18:57:32 -0000
Subject: [PATCH] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <AANLkTikRXgT76Pzv8yiVLN8gRAxvrYu1CWqDjt7V-GH=@mail.gmail.com>
References: <AANLkTik-0SaVbtiXZ-iefvvgLq=7KqRTGi7XPLPEKx85@mail.gmail.com>	<-4413647205110644369@unknownmsgid>	<AANLkTikaZkRMHH1bUmO0pWYT1FgTC+83F5KxPySasG-S@mail.gmail.com>	<146267380211262372@unknownmsgid>	<AANLkTimPDNv+2n2-QHtBq0X+Vkj21yQCPh8iKZkYjfqG@mail.gmail.com>	<alpine.LFD.2.00.1102162008490.2701@localhost6.localdomain6>	<20110217091741.GA24627@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1102171032580.2701@localhost6.localdomain6>	<20110217101957.GC24627@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1102171136550.2701@localhost6.localdomain6>	<20110217105611.GE24627@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1102171203280.2701@localhost6.localdomain6>	<alpine.LFD.2.00.1102171831520.2701@localhost6.localdomain6>	<4D5DB193.5010007@codeaurora.org>	<alpine.LFD.2.00.1102181240370.2701@localhost6.localdomain6>	<-8083923411736601789@unknownmsgid>
	<AANLkTikRXgT76Pzv8yiVLN8gRAxvrYu1CWqDjt7V-GH=@mail.gmail.com>
Message-ID: <000001cbcf9d$b2e75030$18b5f090$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Well, grepping for set_chained_irq_handler yields a whole bunch of platforms
> > but the set of these which appear to use the gic is only:
> >
> > mach-msm
> > mach-s5pv310
> > mach-shmobile
> > mach-tegra
> >
> > I'll have a look through the code there and post some patches next week.
> > Hopefully if I've missed anybody, they'll shout then.
> 
> omap4 uses the gic, and uses chained handlers in plat-omap/gpio.c.
> plat-omap/gpio.c seems to handle similar gpio hardware connected to
> different IRQ controllers on different SoCs - non-gic on omap2-3, and
> gic on omap4.

Thanks for spotting this Colin. My grep-fu failed me because the gic
initialisation for omap is under a different directory to the GPIO cascaded
IRQ stuff (plat- vs mach-).

I'll add OMAP to the list.

Will
