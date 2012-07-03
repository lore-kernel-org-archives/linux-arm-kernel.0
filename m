From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 3 Jul 2012 09:20:40 +0200
Subject: [PATCH 2/9] arm: mach-mvebu: add header
In-Reply-To: <20120703070927.GA17004@lunn.ch>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341243574-3258-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120702183330.GG1348@lunn.ch> <20120702210838.37c78fda@skate>
 <20120702191616.GJ1348@lunn.ch>
 <alpine.LFD.2.02.1207022313550.31003@xanadu.home>
 <20120703070927.GA17004@lunn.ch>
Message-ID: <20120703092040.7f6f6262@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Tue, 3 Jul 2012 09:09:27 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> > Now it seems that all the u-Boot implementations for Orion/Kirkwood out 
> > there have always moved the window containing the serial ports from its 
> > default 0xd0000000 address to 0xf1000000.  Why they did that I have no 
> > idea.  And Linux simply took those remapped physical addresses as 
> > authoritative.
> > 
> > And whether or not Armada 370/XP still have this physical remap ability 
> > I don't know.  And if it does, then why didn't it follow the same 
> > 0xf1000000 tradition as all the other mvebu targets before them I don't 
> > know either.  Maybe this could be considered?
> 
> Thomas, Gregory, could you look at this?

Yes, we will look into this with Marvell engineers.

> Are the uboot source open, or are you using a proprietary Marvell
> version?

As far as I know, there is no support in upstream U-Boot for Armada 370
and XP. We're currently using the internal Marvell U-Boot.

> When Arnd first proposed moving everything into one directory, i had a
> quick look at the memory map. The Orions have more than just the
> serial ports at the same address. If i remember correctly, I2C, SPI,
> PCIE0, USB0, XOR, and ETH0 are all at the same physical
> address. Unfortunately, they have different virtual addresses. So I
> played around unifying the virtual address map.
> 
> Doing this will allow some code simplification, header file
> simplification, and sharing of some .dtsi and DT across all Orion
> systems.
> 
> Its not something i want to do right now, but having 370/XP the same
> as Orion would be a step towards this.

That sounds like a good idea of course, if possible.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
