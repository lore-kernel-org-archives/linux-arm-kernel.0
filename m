From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 Jun 2014 14:12:40 +0800
Subject: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
In-Reply-To: <1403626435.4230.17.camel@weser.hi.pengutronix.de>
References: <20140624153559.GA5741@dragon>
 <1403626435.4230.17.camel@weser.hi.pengutronix.de>
Message-ID: <20140625061238.GA3242@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 06:13:55PM +0200, Lucas Stach wrote:
> Hi Shawn,
> 
> Am Dienstag, den 24.06.2014, 23:36 +0800 schrieb Shawn Guo:
> > Hi Lucas,
> > 
> > I found that imx6q suspend/resume is broken on 3.16-rc, and it works
> > just fine if PCIe support is built out.  However the issue was not
> > exposed on 3.15, so I suspect the PCIe driver change merged in 3.16
> > is part of the cause.
> > 
> I don't yet see why any of the changes to the designware/imx6 host
> driver would cause such failures.
> 
> Which board are you doing your testing on? What devices are connected to
> the PCIe bus? In what way does it break system resume, complete hang?

It's on imx6q-sabresd without any PCIe device connected.  Right, it's a
complete hang after enabling non-boot CPUs.

...
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
<*** hang here ***>

Shawn
