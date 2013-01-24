From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Jan 2013 15:54:27 +0000
Subject: [RFC PATCH 6/6] ARM: kirkwood: consolidate mv643xx_eth init for DT
In-Reply-To: <20130124143736.GZ1758@titan.lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <51013933.9020601@openwrt.org> <20130124143736.GZ1758@titan.lakedaemon.net>
Message-ID: <201301241554.28003.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 January 2013, Jason Cooper wrote:
> I agree, however, there is a long history with that patch.  That driver
> has been in use by powerpc for many years.  We need to be mindful not to
> break existing installations.  I don't think it'll be ready in time for
> v3.9.  So, I'd like to do the cleanup now.
> 
> thx,
> 
> Jason.
> 
> > [1]: http://patchwork.ozlabs.org/patch/175652/

I actually think we can take that patch. The result of the discussion
back then was after all that we won't try to keep the bindings compatible,
and the powerpc version just uses the platform_device part of the driver
by fabricating platform_data from the arch code.

It should not have any impact on this, as long as you ensure that the
platform_data is still supported.

	Arnd
