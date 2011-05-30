From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 31 May 2011 09:27:12 +1000
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio
	card gpio's from the device tree.
In-Reply-To: <20110530070138.GA5036@opensource.wolfsonmicro.com>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
	<20110528012427.GB5971@opensource.wolfsonmicro.com>
	<BANLkTinKLcYmStvBEGDcN84BapJXe5Y5bg@mail.gmail.com>
	<20110530033826.GE4130@opensource.wolfsonmicro.com>
	<20110530061155.GC23517@ponder.secretlab.ca>
	<4DE336A1.5040509@firmworks.com>
	<20110530070138.GA5036@opensource.wolfsonmicro.com>
Message-ID: <1306798032.7481.641.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-30 at 15:01 +0800, Mark Brown wrote:
> On Sun, May 29, 2011 at 08:18:09PM -1000, Mitch Bradley wrote:
> 
> > I'm currently dealing with an SoC that has over a hundred GPIOs.
> > Whatever we choose, I think it should be able to handle an insane
> > number of GPIOs without getting any more cumbersome that is
> > necessary.
> 
> This is *consumer* side GPIOs, not bindings for the device providing the
> GPIOs.  If a single device needs to use hundreds of GPIOs I'd expect
> many of them will be block functions so you'd have a binding with an
> array for things like "databus" and "addrbus".

Yes. Agreed. The producer remains identified by phandle/gpio#, so it's
just a naming thing on the consumer side.

So what are the options ?

 - gpio-xxxx = < ... > properties

 - existing binding, along with an optional gpio-names string list

 - anything else ?

Cheers,
Ben.
