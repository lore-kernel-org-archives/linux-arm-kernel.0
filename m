From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jul 2017 18:44:03 +0100
Subject: [PATCH] arm64: dts: marvell: mcbin: Enable PCIe interface
In-Reply-To: <CAKv+Gu9DXFDDdx3Vrmo20cRtMcbS-MUa4MF5r-Odje68FinGOw@mail.gmail.com>
References: <20170705161333.9315-1-gregory.clement@free-electrons.com>
 <20170705171607.GG4902@n2100.armlinux.org.uk>
 <CAKv+Gu9DXFDDdx3Vrmo20cRtMcbS-MUa4MF5r-Odje68FinGOw@mail.gmail.com>
Message-ID: <20170705174403.GH4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 05, 2017 at 06:36:53PM +0100, Ard Biesheuvel wrote:
> On 5 July 2017 at 18:16, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> > On Wed, Jul 05, 2017 at 06:13:33PM +0200, Gregory CLEMENT wrote:
> >> Enable the PCIe interface on the MACCHIATOBin board. It is located on
> >> CON12 and is 4 lanes capable.
> >>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >
> > Why do you folk at free-electrons like doing half a job all the friggin
> > time?
> >
> > You know I have complete patches for mcbin, but you pointedly won't look
> > at them at all - except when you have a problem and want to test my tree.
> > And even then, you ignore my work (despite testing that it works), and
> > you still recreate my patches.
> >
> > This is really frustrating and insane behaviour on your part.
> >
> > Here's what I have:
> >
> > +&cpm_pcie0 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&cpm_pcie_pins>;
> > +       num-lanes = <4>;
> > +       reset-gpio = <&cpm_gpio1 20 GPIO_ACTIVE_LOW>;
> > +       status = "okay";
> 
> This needs 'num-viewport = <8>' as well, or the crazy Synopsys DWC
> PCIe driver will happily reconfigure the I/O window at runtime to
> perform config space accesses, without any locking whatsoever.

Thanks for the feedback, I'll integrate that change into my patch, so
it's ready for when I rebase after -rc1.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
