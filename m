From: sean.wang@mediatek.com (Sean Wang)
Date: Wed, 28 Mar 2018 11:09:03 +0800
Subject: [PATCH] spi: mediatek: remove redundant MODULE_ALIAS entries
In-Reply-To: <20180328021416.GK29239@sirena.org.uk>
References: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
 <20180328021416.GK29239@sirena.org.uk>
Message-ID: <1522206543.18424.23.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-03-28 at 10:14 +0800, Mark Brown wrote:
> On Mon, Mar 26, 2018 at 06:04:18PM +0800, sean.wang at mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > MODULE_ALIAS exports information to allow the module to be auto-loaded at
> > boot for the drivers registered using legacy platform registration.
> > 
> > However, currently the driver is always used by DT-only platform,
> > MODULE_ALIAS is redundant and should be removed properly.
> 
> There is no meaningful cost to having the alias there, why remove it?


It's no explicitly improved to the driver, it only takes less bytes
in .secion modinfo from 644 bytes to 620 bytes in the observation with
objdump.

More importantly, it seems the driver should probably refer to another
qualified driver at the initial development, but MODULE_ALIAS is
forgetting to be removed to meet real usage for the module autoload. 

Even I was curious whether people for the driver know the actual purpose
the macro it's for.

Removing MODULE_ALIAS is just to correct the driver to where it should
be.
