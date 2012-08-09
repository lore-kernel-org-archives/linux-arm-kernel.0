From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 9 Aug 2012 13:05:30 +0100
Subject: How to get the irq flags from the dts file
In-Reply-To: <201208091148.42748.arnd@arndb.de>
References: <1344509006.2295.148.camel@tegra-chromium-2>
 <201208091148.42748.arnd@arndb.de>
Message-ID: <20120809120530.GC8474@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 11:48:42AM +0000, Arnd Bergmann wrote:
> On Thursday 09 August 2012, Wei Ni wrote:

> > The wlan driver wish this flags include the IRQF_TRGGER_* information,
> > and it will use this flags to configure other hw settings. If it is
> > wrong, the wlan can't work.

You can read the configuration with irqd_get_trigger_type() - see the OF
code in sound/soc/codecs/wm8903.c for an example.

> The driver should not need to know about thie flag. It gets read
> by irq_create_of_mapping when calling teh xlate function and
> gets set using irq_set_irq_type from there too.

That only helps the interrupt controller, it doesn't help the interrupt
source.  A good proportion of embedded devices have a great deal of
flexibility in how they signal interrupts so they need to know what mode
to pick.
