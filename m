From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 2 Jul 2018 13:49:47 +0000
Subject: [PATCH 0/2] soc: imx: gpc: Power off PU domain in suspend/resume
 on 6qp
In-Reply-To: <1530533718.22468.87.camel@pengutronix.de>
References: <cover.1530530881.git.leonard.crestez@nxp.com>
 <1530533718.22468.87.camel@pengutronix.de>
Message-ID: <8dc9a2359f65b570a8a94aad5e8113dfd642e441.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-07-02 at 14:15 +0200, Lucas Stach wrote:
> Am Montag, den 02.07.2018, 14:52 +0300 schrieb Leonard Crestez:

> > With current code (even without my patches) attempting to dynamically
> > remove/probe the GPC fils since since the per-pgc platform_device
> > instances are not removed. I'm trying something like this:
> > 
> > echo 130000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
> > echo 134000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
> > echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/unbind
> > echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/bind
> > 
> > But is there any usecase for dynamically removing the GPC? Instead of
> > trying to fix it I'd rather delete imx_gpc_driver.remove, just like
> > for gpcv2. Would anyone object to a patch doing this?
> 
> Yes, as this is taking things in wrong direction. With device-links we
> are able to unbind consumer devices when a provider is removed. As the
> GPC is a consumer of a regulator, not having the ability to unbind it
> would break that use case.

The GPC is a "consumer" of the LDO regulators which are built into the
SOC. Why would you want to unbind any of this stuff?

I don't understand the usecase, maybe you can elaborate?
