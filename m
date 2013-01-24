From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Jan 2013 11:13:49 -0500
Subject: [RFC PATCH 6/6] ARM: kirkwood: consolidate mv643xx_eth init for DT
In-Reply-To: <201301241554.28003.arnd@arndb.de>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <51013933.9020601@openwrt.org>
 <20130124143736.GZ1758@titan.lakedaemon.net>
 <201301241554.28003.arnd@arndb.de>
Message-ID: <20130124161349.GC1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 03:54:27PM +0000, Arnd Bergmann wrote:
> On Thursday 24 January 2013, Jason Cooper wrote:
> > I agree, however, there is a long history with that patch.  That driver
> > has been in use by powerpc for many years.  We need to be mindful not to
> > break existing installations.  I don't think it'll be ready in time for
> > v3.9.  So, I'd like to do the cleanup now.
> > 
> > > [1]: http://patchwork.ozlabs.org/patch/175652/
> 
> I actually think we can take that patch.

Woot!

> The result of the discussion back then was after all that we won't try
> to keep the bindings compatible, and the powerpc version just uses the
> platform_device part of the driver by fabricating platform_data from
> the arch code.
> 
> It should not have any impact on this, as long as you ensure that the
> platform_data is still supported.

Ian's patch appears to do so.  I'll respin this series using it vice my
lookup table.

thx,

Jason.
