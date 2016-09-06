From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2016 15:24:42 +0100
Subject: [PATCH] ARM: mmp: replace NO_IRQ
In-Reply-To: <20160906140808.2883875-1-arnd@arndb.de>
References: <20160906140808.2883875-1-arnd@arndb.de>
Message-ID: <20160906142442.GY1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 04:07:56PM +0200, Arnd Bergmann wrote:
> The mmp platform has its own definitions with the old NO_IRQ meaning,
> but compares against the global NO_IRQ macro that we should have
> removed long ago.
> 
> The specific usage in arch/arm/mach-mmp/devices.c is awkward, but
> fixing it properly would require a larger scale rewrite of the entire
> file, or even using devicetree for all machines. As I'm not able to
> do that any time soon, let's make the current behavior more explit
> instead and avoid the literal use of NO_IRQ.

So this probably continues to be a problem, but we hide it from the
NO_IRQ brigade.  I think it would be better to leave it as-is until
it can be fixed up correctly, rather than trying to hide it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
