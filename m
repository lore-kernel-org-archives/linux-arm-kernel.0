From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Sep 2014 13:03:13 +0100
Subject: [PATCH 6/6 v4] ARM: realview: basic device tree implementation
In-Reply-To: <9626823.572BIYcQL9@wuerfel>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
 <20140725152401.GA21830@leverpostej>
 <20140725155010.GP21766@n2100.arm.linux.org.uk> <9626823.572BIYcQL9@wuerfel>
Message-ID: <20140901120313.GI30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 05:58:24PM +0200, Arnd Bergmann wrote:
> On Friday 25 July 2014 16:50:10 Russell King - ARM Linux wrote:
> > 
> > I toyed with the idea of adding the standard cache size specifications
> > to the L2C code, it sounds like there's a reason to do that now.
> > 
> > Let's not mess around with adding stuff like the above to work around
> > the L2 code not parsing the appropriate specs from DT, let's do the
> > right thing and add bindings to allow DT to provide the cache geometry.
> 
> Yes, please!
> 
> That would actually reduce the realview to just the dma_zone_size
> definition, and I think someone also posted a patch to get that from
> DT recently. Having realview booting with an empty board file would
> be ideal.

I did have a patch in my L2C cleanup series to provide these properties,
but it got discarded - even though we have existing platforms which
provide these values.

The reason for that was because requiring new properties causes a DT
breakage - previous versions of the DT suddenly stop working because
the values necessary to setup the L2C have been removed from the
kernel, and the older DT files do not contain the neccessary values
either.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
