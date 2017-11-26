From: peng.fan@nxp.com (Peng Fan)
Date: Sun, 26 Nov 2017 23:56:10 +0000
Subject: [PATCH] arm: l2c: unlock ways when in non-secure mode
In-Reply-To: <20171126131812.GZ31757@n2100.armlinux.org.uk>
References: <20171126122530.857-1-peng.fan@nxp.com>
 <20171126131812.GZ31757@n2100.armlinux.org.uk>
Message-ID: <DB6PR04MB3221D60D0EC8D5B31869AA6588240@DB6PR04MB3221.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> Subject: Re: [PATCH] arm: l2c: unlock ways when in non-secure mode
> 
> On Sun, Nov 26, 2017 at 08:25:30PM +0800, Peng Fan wrote:
> > To boot Linux in Non-secure mode with l2x0, the l2x0 controller is
> > enabled in secure mode and ways locked to make it seems L2 cache
> > disabled during linux boot process. So during l2x0 initialization,
> > need to unlock the ways to make l2x0 could cache data/inst.
> 
> Why was this chosen instead of doing what everyone else does?

I am not aware of how other platform handles the l2x0 unlock in non
secure mode. Could you please share with me what others choose?

Thanks,
Peng.

> 
> --
> RMK's Patch system:
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> armlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=02%7C01%7Cpeng.fan%4
> 0nxp.com%7C277f5508e3ef412c3dc908d534d031ab%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C636472991153380699&sdata=6QBrJCdmtU%2B4GO8
> YsYMvcvRwwk5ST2B87%2BWY%2BhPRxP8%3D&reserved=0
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
