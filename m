From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Sep 2012 11:17:45 +0000
Subject: [PATCH v2 08/13] mfd: Versatile Express system registers driver
In-Reply-To: <1348052009.11116.55.camel@hornet>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <201209181524.22620.arnd@arndb.de> <1348052009.11116.55.camel@hornet>
Message-ID: <201209191117.45316.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 September 2012, Pawel Moll wrote:
> On Tue, 2012-09-18 at 16:24 +0100, Arnd Bergmann wrote:
> > On Tuesday 18 September 2012, Pawel Moll wrote:
> 
> Yes, but I2C devices are created by of_i2c_register_devices() which
> knows how to interpret the reg property. And here, as these are normal
> platform devices now (as you suggested), the of_platform_bus_create()
> will treat it as a normal address, translate it via ranges and create
> IORESOURCE_MEM out of it... And that's what I wanted to avoid. Maybe
> unnecessarily?

You are right, this is a bit nasty, it should not attempt to do this.
Basically the reg parsing logic has a hack to work around apply PowerMac
firmware that misses some "ranges" properties.

I think we should change the DT parsing code to not create those
resources if there is a bus that can't be translated.

	Arnd
