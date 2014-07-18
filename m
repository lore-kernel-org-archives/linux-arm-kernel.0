From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 18 Jul 2014 11:21:48 +0200
Subject: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
In-Reply-To: <247043c4c45c41bf9eaa09aaf91bcc46@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <20140625062243.GD3242@dragon>
 <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
 <1403693452.4249.1.camel@weser.hi.pengutronix.de>
 <20140625125306.GB6917@dragon>
 <1403772229.4254.4.camel@weser.hi.pengutronix.de>
 <20140628143712.GA7869@dragon>
 <1404135864.4305.23.camel@weser.hi.pengutronix.de>
 <20140701065105.GE14471@dragon>
 <1404724251.4587.20.camel@weser.hi.pengutronix.de>
 <20140707135502.GR30239@dragon> <20140716065505.GB2612@dragon>
 <1405605306.12800.7.camel@weser.hi.pengutronix.de>
 <247043c4c45c41bf9eaa09aaf91bcc46@DM2PR0301MB0862.namprd03.prod.outlook.com>
Message-ID: <1405675308.6072.6.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 18.07.2014, 02:11 +0000 schrieb
Hong-Xing.Zhu at freescale.com:
> > -----Original Message-----
> > From: Lucas Stach [mailto:l.stach at pengutronix.de]
> > Sent: Thursday, July 17, 2014 9:55 PM
> > To: Guo Shawn-R65073
> > Cc: Zhu Richard-R65037; linux-pci at vger.kernel.org; Sascha Hauer; Bjorn Helgaas;
> > Shawn Guo; Fabio Estevam; linux-arm-kernel at lists.infradead.org
> > Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
> > 
> > Hi Shawn,
> > 
> > Am Mittwoch, den 16.07.2014, 14:55 +0800 schrieb Shawn Guo:
> > > On Mon, Jul 07, 2014 at 09:55:03PM +0800, Shawn Guo wrote:
> > > > On Mon, Jul 07, 2014 at 11:10:51AM +0200, Lucas Stach wrote:
> > > > > Hi Shawn,
> > > > >
> > > > > Over the weekend I tried to reproduce your problem on a SabreSD
> > > > > board, but wasn't able to trigger the issue. 3.16-rc3 with PCIe
> > > > > active works just fine over a suspend and resume cycle for me.
> > > >
> > > > That's strange.  In my setup, PCIe support is enabled in kernel and
> > > > DT, but I do not have a PCIe device connected to the board.
> > > >
> > > > >
> > > > > One possibly relevant difference is that I've booted with NFSroot,
> > > > > while it seems you are using a SATA connected device. Is this right?
> > > >
> > > > I have a SATA disk connected, but did boot with NFSroot.
> > > >
> > > > > If so,
> > > > > can you test if it works if you boot from SDcard or the like? This
> > > > > might be relevant as PCIe and SATA share some clocks.
> > > >
> > > > I tried to disable SATA support completely, but it doesn't help.
> > >
> > > Lucas, any news on this?  Or should we just try to use Richard's patch
> > > to solve the problem?
> > 
> > I would like to understand the problem first before throwing "fixes" at the
> > issue. As you said this isn't a regression we are in no hurry and should try
> > to analyze the issue properly. I just retested and I'm still not able to
> > reproduce the issue on my SabreSD. Maybe there are board revision that exhibit
> > different behavior? My board has two sticks on saying "Rev B3" and "Rev X3".
> > 
> > As you can see from the log suspend/resume is working fine for me with kernel
> > 3.16-rc5 + imx_v6_v7_defconfig.
> [Richard] As I know that imx6 pcie is not enabled in imx_v6_v7_defconfig in default.
> Menu-config is required if you want to tests system suspend/resume with pcie built-in.
> Just double confirm, is the pcie built-in at your side?

This is not right, PCI is enabled in imx_v6_v7_defconfig since
c0bea59ca58e30fb8fd29254569bdaae482398ad "ARM: imx_v6_v7_defconfig:
Select PCI support".

However I seem to have a board with rev 1.1 silicon and although the pci
driver starts up it never establishes a link. So my board may just work
by chance as I don't really know the differences between rev 1.1 silicon
and later revisions.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
