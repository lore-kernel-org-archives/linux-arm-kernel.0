From: alior@marvell.com (Lior Amsalem)
Date: Wed, 16 May 2012 14:12:39 +0300
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120515164438.22258885@skate>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515091838.GC6820@lunn.ch>	<4FB22727.6090406@codethink.co.uk>
 <20120515115511.75ece9c3@skate>	<4FB269CB.4080804@gmail.com>
 <20120515164438.22258885@skate>
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801A56AA0A462@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni at free-electrons.com]
> Sent: Tuesday, May 15, 2012 5:45 PM
> To: Rob Herring
> Cc: Ben Dooks; Lior Amsalem; Andrew Lunn; Jason Cooper; Arnd Bergmann;
> Nicolas Pitre; Maen Suleiman; Ben Dooks; Olof Johansson; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] arm: Add basic support for new Marvell Armada SoC
> family
> 
> Le Tue, 15 May 2012 09:35:55 -0500,
> Rob Herring <robherring2@gmail.com> a ?crit :
> 
> > Directory location doesn't really have anything to do with what can be
> > in a single kernel binary. We will soon be building single images
> > across mach directories.
> 
> Agreed, but it's not the case right now, and we wanted to submit today a
> kernel that boots on both of those SoCs.
> 
> The 370 and XP both use the PJ4B core, which is a Marvell implementation of
> an ARMv7 compatible core. The 370 has one PJ4B, and the various XP variants
> have a choice of 2 or 4 PJ4Bs, and various other differences. To us, it makes a
> lot of sense to be able to support those SoCs together in the same kernel
> image and in the same directory, even if both concepts are not directly tied
> together.
> 
> > With some hacks and limitations, Arnd has built (not run) omap2+,
> > u8500, imx and one other in a single kernel.
> > If there's overlap with dove or other platforms, then they should
> > probably all be combined into a single mach directory. One option
> > would be make the new mach directory somewhat generic and then later
> > move dove or others into the new directory.
> 
> This would be one solution.
> 
> On the naming side, we are really open to what the community prefers.
> We knew there would be quite a bit of discussion around this, because
> there's a lot quite a few Marvell SoCs supported in various places, and it's not
> obvious what's the right place and name for a new SoC family.
> 
> What about making it mach-marvell, which would contain the DT-enabled
> SoC support for Marvell SoCs? We can start with 370 and XP today, and
> gradually add future SoCs, or even port previous SoCs as they are moved to
> support the device tree.
> 
> Again we're really open on the solution. Lior from Marvell can give all the
> necessary input to explain how the SoC family is organized.

I'll try to arrange our SoCs (EBU):

Orion family:
      Flavors:
            5082, 5181, 5181L, 5281, 6183, ...
      Core: ARMv5 compatible (Feroceon and Jolteon)
      Process: 90nm
      Directory: mach-orion5x
 
Kirkwood family:
      Flavors:
      6190, 6192, ...
          Core: ARMv5 compatible (Gandalf)
          Process: 65nm
          Directory: mach-kirkwood

      6282 a.k.a Kirkwood 55, Armada 300
      6283 a.k.a Kirkwood 55, Armada 310
          Core: ARMv5 compatible (Gandalf)
          Process: 55nm
          Directory: not in mainline, future plan

      6710 a.k.a Kirkwood 40, Armada 370
          Core: ARMv7 compatible (PJ4B)
          Process: 40nm
          Directory: new code

Discovery family:
      Flavors:
      78100/78200 a.k.a DiscoDuo
          Core: ARMv5 compatible (Gandalf)
          Process: 65nm
          Directory: mach-mv78xx0

      78230/78260/78460 a.k.a DiscoSMP, Armada XP
          Core: ARMv7 compatible (PJ4B)
          Process: 40nm
          Directory: new code

Avanta family: (a.k.a Kirkwood 2)
      Flavors:
      6560/60, 6530P, 6510
          Core: ARMv5 compatible (Gandalf)
          Process: 55nm
          Directory: no code in mainline yet, future plan

Dove: (application processor)
      Flavors:
      ap510 a.k.a Armada 510
          Core: ARMv7 compatible (PJ4)
          Process: 65nm
          Directory: mach-dove

plat-orion holds code shared between the SoCs.
There are more SoCs called Armada which are developed in other business 
units in Marvell (mmp, pxa) but I'm not that familier with it.

I hope it helps mapping the different SoCs.

> 
> Best regards,
> 
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux development, consulting,
> training and support.
> http://free-electrons.com


Lior Amsalem
