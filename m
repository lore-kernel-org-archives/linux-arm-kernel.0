From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 May 2011 11:24:08 +0100
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <20110530234909.GA3411@quad.lixom.net>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
	<20110528012427.GB5971@opensource.wolfsonmicro.com>
	<BANLkTinKLcYmStvBEGDcN84BapJXe5Y5bg@mail.gmail.com>
	<20110530033826.GE4130@opensource.wolfsonmicro.com>
	<20110530061155.GC23517@ponder.secretlab.ca>
	<4DE336A1.5040509@firmworks.com>
	<20110530070138.GA5036@opensource.wolfsonmicro.com>
	<1306798032.7481.641.camel@pasglop>
	<20110530234909.GA3411@quad.lixom.net>
Message-ID: <20110531102407.GD7067@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 04:49:09PM -0700, Olof Johansson wrote:

> What I was not sure about was the use of having an array of unnamed
> gpios as part of the consumer-side binding, where there's no logical
> ordering between these entries.

> In the sdhci case, there are three gpios; one to supply power to the slot;
> one for card detect and one for write protect sense.

> In that case, it would make a whole lot more sense to have three separate
> properties, say "power-gpio", "cd-gpio" and "wp-gpio", than an opaque array of
> entries without description besides what comments are used in the dts file.

> That these in turn point just to gpio number <x> at controller <y> is OK with
> me. Also, I can see cases where it makes sense to have more than one gpio
> references in a property (i.e. busses), but only where there's either internal
> ordering to them, or where ordering doesn't matter at all.

I agree strongly with this - there's a very good reason why this is the
existing pattern for platform data.  There's other cases that are even
worse than SDHCI where you can get a large number of potential outputs
from a device that could be wired up, a vanishingly small number
(possibly even none) of which will actually be used in a given system.
