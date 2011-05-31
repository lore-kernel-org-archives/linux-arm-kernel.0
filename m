From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Tue, 31 May 2011 02:58:46 +0200
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
Message-ID: <4b2d531979e9f806b9ea8d25b1ab5c7f@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The producer side works fine as-is, agreed.

+1

> What I was not sure about was the use of having an array of unnamed
> gpios as part of the consumer-side binding, where there's no logical
> ordering between these entries.
>
> In the sdhci case, there are three gpios; one to supply power to the 
> slot;
> one for card detect and one for write protect sense.
>
> In that case, it would make a whole lot more sense to have three 
> separate
> properties, say "power-gpio", "cd-gpio" and "wp-gpio", than an opaque 
> array of
> entries without description besides what comments are used in the dts 
> file.

Yes.  And this way you can also show a specific board doesn't have a
specific function GPIO wired up by simply not having the property for
it, instead of that ugly 0 phandle business.

> That these in turn point just to gpio number <x> at controller <y> is 
> OK with
> me.

Controller <y> GPIO # <x> with flags <w>, yes.  A generic "GPIO 
specifier".

>  Also, I can see cases where it makes sense to have more than one gpio
> references in a property (i.e. busses), but only where there's either 
> internal
> ordering to them, or where ordering doesn't matter at all.

That's up to the device binding, let's hope the people who write those
show good judgement :-)


Segher
