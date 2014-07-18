From: marex@denx.de (Marek Vasut)
Date: Fri, 18 Jul 2014 22:46:20 +0200
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
In-Reply-To: <20140717152707.GA8537@dragon>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
 <201407171023.10908.marex@denx.de> <20140717152707.GA8537@dragon>
Message-ID: <201407182246.20911.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 17, 2014 at 05:27:09 PM, Shawn Guo wrote:
> On Thu, Jul 17, 2014 at 10:23:10AM +0200, Marek Vasut wrote:
> > On Thursday, July 17, 2014 at 08:51:48 AM, Uwe Kleine-K?nig wrote:
> > > Hello,
> > > 
> > > On Tue, Jun 24, 2014 at 04:18:27PM -0300, Fabio Estevam wrote:
> > > > From: Fabio Estevam <fabio.estevam@freescale.com>
> > > > 
> > > > When the mx6 PCI conctroller is initialized in the bootloader we see
> > > > a kernel hang inside imx6_add_pcie_port().
> > > > 
> > > > Adding a 30ms delay allows the kernel to boot.
> > > 
> > > Just my thought on how to debug that: I'd try to bisect the pci init
> > > routine in the boot loader. I.e. first only do the first half of the
> > > initialisation in U-Boot. Depending on Linux being able to boot or not
> > > initialize more or less on the next run.
> > > 
> > > Maybe there is a single register write that makes Linux fail?!
> > 
> > I am still hell-bent on thinking that the missing PCIe block reset is
> > what makes the Linux fail. Missing block reset is always a problem.
> 
> Indeed.  We're missing a hardware reset for PCIe on i.MX6Q and i.MX6DL.
> Such reset is available on i.MX6SX, so there is no this problem for
> i.MX6SX PCIe.
> 
> > Or do we now have a
> > mean to reset the PCIe block and it's PHY from software?
> 
> Richard is trying to find a SW workaround for it, but we're not really
> sure if it's possible.

I hate to ask this, but does that mean all but MX6SLX are irrepairably broken 
and will never have a reliable PCIe implementation ever?

Best regards,
Marek Vasut
