From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 09 Jan 2018 15:24:46 +0100
Subject: soc: imx: gpcv2: removing and probing fails
In-Reply-To: <3f836677c6e98aaf01bc1ac8c3410083@agner.ch>
References: <3f836677c6e98aaf01bc1ac8c3410083@agner.ch>
Message-ID: <1515507886.12538.33.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, den 07.01.2018, 11:48 +0100 schrieb Stefan Agner:
> Hi Andrew,
> 
> I noticed that the driver fails when removing and probing again. As far
> as I can see due to duplicate add of the platform devices.
> 
> As far as I can tell the driver should register the remove callback and
> do a platform_device_unregister on the newly created platform devices.
> However, as far as I can tell we don't hold on to a reference to them...
> I guess we could keep references in imx_gpcv2_probe, but maybe there is
> an easier way?

The GPC v1 driver adds the necessary device dependency between the
power domain devices and the GPC parent device. See the
device_link_add() in imx_pgc_power_domain_probe().

Probably something similar can be done to the GPC v2 driver.

Regards,
Lucas
