From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 Jan 2016 08:29:17 +0100
Subject: [PATCH 2/3] thermal: Add Mediatek thermal controller support
In-Reply-To: <20160104141940.GI13058@pengutronix.de>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
 <20151217193332.GB7999@localhost.localdomain>
 <20160104141940.GI13058@pengutronix.de>
Message-ID: <20160119072917.GA13237@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eduardo,

On Mon, Jan 04, 2016 at 03:19:40PM +0100, Sascha Hauer wrote:
> Hi Eduardo,
> 
> > 
> > That should remove the policy of computing the maximum from this driver.
> > Please have a look on the work being done [1] to add grouping and
> > aggregation of thermal zones. With that in place, you should be a matter
> > of configuring the grouping and selecting max as the aggregation function,
> > from the thermal core, instead in the driver. Which should give the
> > system engineer, more flexibility to compose whatever policy based on
> > the exposed sensors.
> 
> I think the aggregation of thermal zones is quite useful when it comes
> to putting different chips together to a system. I am not so sure how
> useful it is to expose different thermal zones of a single SoC to the
> device tree.
> Currently the only control knob we have is the CPU frequency. When any
> of the sensors on the SoC gets too hot then the only thing we can do is
> to decrease the CPU frequency. This does not leave much space for
> configuration in the device tree.
> What I need to be able is to attach multiple sensors to one thermal
> zone. The aggregation patch series only partly solves that and I think
> is inconsistent, but I commented on the series directly.

Any input on this? I really like to get this driver upstream as it is
currently blocking other Mediatek drivers.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
