From: alex@digriz.org.uk (Alexander Clouter)
Date: Sun, 13 Apr 2014 18:36:24 +0100
Subject: Marvell Orion5x boards with PCIe, and DT conversion
In-Reply-To: <20140411155735.109c5d04@skate>
References: <20140411155735.109c5d04@skate>
Message-ID: <20140413173624.GA6166@marmot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 03:57:35PM +0200, Thomas Petazzoni wrote:
>
>I am contacting you because you are all maintainers/contributors to
>Marvell Orion5x boards supported in the Linux kernel.
>
>I am currently converting the mach-orion5x to the Device Tree. I have
>two Orion5x boards, so I was able to test most of the interfaces myself.

I had a stab at doing my board about a year ago and put together:

https://github.com/jimdigriz/ts78xx/blob/ts78xx/arch/arm/mach-orion5x/board-ts7800.c
https://github.com/jimdigriz/ts78xx/blob/ts78xx/arch/arm/boot/dts/orion5x-ts7800.dts

>However, one interface I'm not able to test is the PCI Express one, and
>therefore I wanted to let you know if one of you still has a working
>Orion5x board that has a PCI Express interface that is actually usable.

>Note that Orion5x SOCs have both a classical PCI interface and a PCI
>Express interface. On one of my board, I have the classical PCI
>interface, so I can easily test this. However, I don't have a board
>with the PCI Express interface.

Alas, PCI only (although at the end of my 'PCI bus') lurks an FPGA
soaking up the whole IO range.

>Moreover, I will be sending in the near future a set of patches
>converting many of the boards to the Device Tree, so if you still have
>those boards and are willing to test the conversion, it would be very
>useful.

As a heads up...the problem I had[1] was as the NAND on my board is not
handled with the usual orion controller, its a proprietary thing handled
by the the onboard FPGA:

https://github.com/jimdigriz/ts78xx/blob/plat-nand/arch/arm/mach-orion5x/board-ts7800.c#L199

The patch I used for that extends plat-nand and I need to pull out my thumb
and do something further with this:

http://lists.infradead.org/pipermail/linux-mtd/2013-September/048701.html

In my repo are also branches for getting the rtc-m48t86/timeriomem-rng
drivers DT aware.

If you tell me what a pain in the ass it is that I have not pushed
and got these mainlined/run-by-you, that will probably motivate me
enough to actually find some time to do this :)

Thanks for your DT work!

[1] other than the xor crashing the board and needing to be disabled

-- 
Alexander Clouter
.sigmonster says: Is a wedding successful if it comes off without a hitch?
