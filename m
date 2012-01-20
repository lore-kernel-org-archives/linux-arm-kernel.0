From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:39:56 +0000
Subject: [PATCH 00/19] ARM SA11x0 / PXA / SoC-common PCMCIA cleanups
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <20120120103956.GG1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 10:17:09AM +0000, Russell King - ARM Linux wrote:
> What follows is a series of 19 patches cleaning up the SA11xx and PXA
> PCMCIA support, which uses the soc-common infrastructure.
> 
> Now that we have proper gpiolib support in the kernel for these platforms,
> with properly implemented gpio_to_irq() functionality, we can move some
> things that the individual platform socket drivers were doing into the
> soc-common core.
> 
> This significantly reduces the code in the platform socket drivers -
> a reduction of around 550 lines, for the net addition of about 50 lines
> to soc-common.
> 
> The final set of five patches in this set contain some minor bug fixes
> (which are really low priority) and cleanup the handling of the SA1111
> build between PXA and SA11x0 platforms.
> 
> Please supply acks; I have other work which touches the header files
> in arch/arm which would conflict, and it would help to keep it together
> rather than have SFR carry those resolutions.

I should add that these changes have been tested on the Assabet (SA1110)
and Assabet with Neponset daughter board (SA1111) platforms with a CF
network card and a PCMCIA wireless card.

There are a couple of bugs in genirq which stop both the original code,
and these updates from working correctly.  These changes in itself do
not cause a regression as a result of that.  This is in the hands of
the genirq people to resolve as it's a regression - this code worked
100% with the ARM IRQ layer, which was part of the basis for genirq.
