From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Apr 2018 17:13:23 +0100
Subject: [PATCH] spi: mediatek: remove redundant MODULE_ALIAS entries
In-Reply-To: <1522206543.18424.23.camel@mtkswgap22>
References: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
 <20180328021416.GK29239@sirena.org.uk>
 <1522206543.18424.23.camel@mtkswgap22>
Message-ID: <20180412161323.GH9929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 11:09:03AM +0800, Sean Wang wrote:
> On Wed, 2018-03-28 at 10:14 +0800, Mark Brown wrote:
> > On Mon, Mar 26, 2018 at 06:04:18PM +0800, sean.wang at mediatek.com wrote:
> > > From: Sean Wang <sean.wang@mediatek.com>

> > > MODULE_ALIAS exports information to allow the module to be auto-loaded at
> > > boot for the drivers registered using legacy platform registration.

> > > However, currently the driver is always used by DT-only platform,
> > > MODULE_ALIAS is redundant and should be removed properly.

> > There is no meaningful cost to having the alias there, why remove it?

> It's no explicitly improved to the driver, it only takes less bytes
> in .secion modinfo from 644 bytes to 620 bytes in the observation with
> objdump.

OK, that's a *very* small saving though especially given the block sizes
that filesystems tend to use.

> More importantly, it seems the driver should probably refer to another
> qualified driver at the initial development, but MODULE_ALIAS is
> forgetting to be removed to meet real usage for the module autoload. 

I can't parse the above, sorry.

> Even I was curious whether people for the driver know the actual purpose
> the macro it's for.

> Removing MODULE_ALIAS is just to correct the driver to where it should
> be.

To me it's the other way around - ideally platform drivers should
remember to set up the MODULE_ALIAS, just as a joining the dots thing to
make sure that things that work when the driver is built in work when
built as a module.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/1376d8e9/attachment.sig>
