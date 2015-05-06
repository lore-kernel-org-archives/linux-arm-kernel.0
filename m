From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 06 May 2015 13:12:07 +0200
Subject: [PATCH] ARM: dts: imx6qdl-hummingboard: Add PCIe support
In-Reply-To: <CALHpu36GENbeCHf-8HDGwX=weCpb5kCzD_02ZAeXOs3NcW-nzA@mail.gmail.com>
References: <1428540113-24616-1-git-send-email-festevam@gmail.com>
 <20150427085156.GG9231@dragon>
 <20150506103541.GI2067@n2100.arm.linux.org.uk>
 <CALHpu36GENbeCHf-8HDGwX=weCpb5kCzD_02ZAeXOs3NcW-nzA@mail.gmail.com>
Message-ID: <1430910727.2473.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

Am Mittwoch, den 06.05.2015, 13:04 +0200 schrieb Jon Nettleton:
> On Wed, May 6, 2015 at 12:35 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > On Mon, Apr 27, 2015 at 04:51:57PM +0800, Shawn Guo wrote:
> > > On Wed, Apr 08, 2015 at 09:41:53PM -0300, Fabio Estevam wrote:
> > > > From: Fabio Estevam <fabio.estevam@freescale.com>
> > > >
> > > > Add PCIe support. Based on a patch from Rabeeh Khoury from the solid-run
> > > > tree.
> > > >
> > > > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > >
> > > Russell,
> > >
> > > Are you fine with this patch?
> >
> > I don't have a view on this because I don't have any experience of PCIe.
> > However, I don't see anything obviously wrong with the patch.
> >
> 
> That patch is fine.  In the SolidRun kernel we are actually using
> 0x80000000 as our pin strength to accept the default value, but I have
> previously tested with 0x1b0b1 and it works as expected.
> 
> I have not tested this with the upstream kernel but previously MSI was
> not working properly on the iMX6 pcie implementation.  This was worked
> around by either disabling the kernel config option, or add pci=nomsi
> to the kernel commandline.  I currently have a patch that takes a
> nomsi device-tree option to workaround this bug.
> 
> Is pcie working with MSI now on the iMX6 hardware?
> 
> -Jon
> 

MSI is working properly on i.MX6 with all devices I had a chance to
test. If you've got some specific devices where it doesn't work with a
mainline kernel I would be interested in receiving bug reports.

It is certainly no hardware limitation, so please don't push a
workaround into DT.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
