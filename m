From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 Jul 2014 14:55:06 +0800
Subject: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
In-Reply-To: <20140707135502.GR30239@dragon>
References: <20140625062243.GD3242@dragon>
 <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
 <1403693452.4249.1.camel@weser.hi.pengutronix.de>
 <20140625125306.GB6917@dragon>
 <1403772229.4254.4.camel@weser.hi.pengutronix.de>
 <20140628143712.GA7869@dragon>
 <1404135864.4305.23.camel@weser.hi.pengutronix.de>
 <20140701065105.GE14471@dragon>
 <1404724251.4587.20.camel@weser.hi.pengutronix.de>
 <20140707135502.GR30239@dragon>
Message-ID: <20140716065505.GB2612@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 09:55:03PM +0800, Shawn Guo wrote:
> On Mon, Jul 07, 2014 at 11:10:51AM +0200, Lucas Stach wrote:
> > Hi Shawn,
> > 
> > Over the weekend I tried to reproduce your problem on a SabreSD board,
> > but wasn't able to trigger the issue. 3.16-rc3 with PCIe active works
> > just fine over a suspend and resume cycle for me.
> 
> That's strange.  In my setup, PCIe support is enabled in kernel and DT,
> but I do not have a PCIe device connected to the board.
> 
> > 
> > One possibly relevant difference is that I've booted with NFSroot, while
> > it seems you are using a SATA connected device. Is this right?
> 
> I have a SATA disk connected, but did boot with NFSroot.
> 
> > If so,
> > can you test if it works if you boot from SDcard or the like? This might
> > be relevant as PCIe and SATA share some clocks.
> 
> I tried to disable SATA support completely, but it doesn't help.

Lucas, any news on this?  Or should we just try to use Richard's patch
to solve the problem?

Shawn
