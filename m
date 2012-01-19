From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 19 Jan 2012 13:27:32 +0000
Subject: [PATCH v6 9/9] ARM: vexpress: Add Device Tree for V2P-CA15 core
 tile (TC1 variant)
In-Reply-To: <4F0C495C.4000103@citrix.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-10-git-send-email-pawel.moll@arm.com>
 <4F0C495C.4000103@citrix.com>
Message-ID: <1326979652.32197.66.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-01-10 at 14:21 +0000, David Vrabel wrote:
> On 15/12/11 14:02, Pawel Moll wrote:
> > This patch adds Device Tree file for the CoreTile Express A15x2
> > (V2P-CA15) with Test Chip 1.
> 
> This doesn't work as-is with the software model as accessing some of the
> peripherals that aren't modeled will cause an exception.  Is it worth
> having a device tree file suitable for the models? Or are the models too
> configurable for this to be workable?

The model as you have it doesn't exactly represent the board for a
number of reasons, mainly because there was no hardware design when the
model was created, so some of the solution was best-guessed by the model
people. Anyway, current A15 model can't be considered a 1-to-1
equivalent of the VE board. The plan is that the models will be shipped
with their own DTSes. I'll work on that in the following months, I can
keep you updated (and use as a beta tester ;-) if you want.

> > As the chip's GIC has 160 interrupt inputs and equivalent SMM
> > (FPGA) has GIC synthesised with 256 interrupts, NR_IRQS is
> > increased.
> > 
> [...]
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
> [...]
> > +	memory at 80000000 {
> > +		device_type = "memory";
> > +		reg = <0x80000000 0x40000000>;
> > +	};
> 
> If CONFIG_ARM_ATAG_DTB_COMPAT is enabled the device tree will end up
> with two nodes describing the memory ("memory" and "memory at 80000000" in
> this case).

You're right - the skeleton.dtsi contains "memory" mode... Funnily
enough originally I was using that name, but then Rob Herring suggested
changing it to @80000000, which seemed reasonable.

Now I wonder - is the "memory" node special and should not contain
"@address", or the skelton shouldn't contain the empty "memory" node...

Cheers!

Pawe?
