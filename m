From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 12 Jun 2013 18:12:22 -0300
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <201306122245.55960.arnd@arndb.de>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <4160363.LWJuHATm2F@wuerfel> <20130612111441.E6D603E0A56@localhost>
 <201306122245.55960.arnd@arndb.de>
Message-ID: <20130612211221.GB23012@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 10:45:55PM +0200, Arnd Bergmann wrote:
> On Wednesday 12 June 2013, Grant Likely wrote:
> > I think we should have almost everything needed already to do this.
> > of_bus allows arbitrary mapping code to be used at any stage in the
> > translation. We might need to add some glue so that of_busses[] can
> > be assembled by the linker to allow an mbus of_bus stanza to live
> > outside of drivers/of/address.c
> > 
> 
> Actually, the best thing about this solution is that we don't even
> have to bother setting up the mappings when loading the mbus driver:
> We don't need any ranges (other than internal-regs) in DT, and we
> don't need complex logic to search through the child devices to
> figure out what the mappings should be. The only thing one needs
> to do here is check if a mapping already exists when we get into the
> of_bus handler and create one for the device being translated if
> there isn't one!
> 

This departs considerably from what I'm aiming right now.

Are you suggesting to not put *any* mapping in the mbus 'ranges' node in
the DT (other than internal-regs)?

In that case, can you explain a bit further how the mbus would
decide a base address for each window? I guess you're thinking
in a first-fit algorithm, right?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
