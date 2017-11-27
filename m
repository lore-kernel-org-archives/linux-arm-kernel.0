From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Nov 2017 09:19:38 +0000
Subject: [PATCH] arm: l2c: unlock ways when in non-secure mode
In-Reply-To: <DB6PR04MB3221D60D0EC8D5B31869AA6588240@DB6PR04MB3221.eurprd04.prod.outlook.com>
References: <20171126122530.857-1-peng.fan@nxp.com>
 <20171126131812.GZ31757@n2100.armlinux.org.uk>
 <DB6PR04MB3221D60D0EC8D5B31869AA6588240@DB6PR04MB3221.eurprd04.prod.outlook.com>
Message-ID: <20171127091937.GA31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 26, 2017 at 11:56:10PM +0000, Peng Fan wrote:
> Hi Russell,
> 
> > Subject: Re: [PATCH] arm: l2c: unlock ways when in non-secure mode
> > 
> > On Sun, Nov 26, 2017 at 08:25:30PM +0800, Peng Fan wrote:
> > > To boot Linux in Non-secure mode with l2x0, the l2x0 controller is
> > > enabled in secure mode and ways locked to make it seems L2 cache
> > > disabled during linux boot process. So during l2x0 initialization,
> > > need to unlock the ways to make l2x0 could cache data/inst.
> > 
> > Why was this chosen instead of doing what everyone else does?
> 
> I am not aware of how other platform handles the l2x0 unlock in non
> secure mode. Could you please share with me what others choose?

That's not what I was asking.

Everyone else provides a way for the l2x0 controller to be enabled and
disabled from non-secure mode.

Why have you decided to enable the l2x0 controller and leave it enabled,
and then lock down all the cache ways - which means you need the kernel
to do something entirely different for your platform.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
