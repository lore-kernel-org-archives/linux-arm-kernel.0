From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 May 2018 11:03:59 +0100
Subject: [PATCH 03/14] ARM: bugs: hook processor bug checking into SMP
 and suspend paths
In-Reply-To: <b454e37c-52a8-387f-3649-8ce72c9a5b18@gmail.com>
References: <20180521114238.GN17671@n2100.armlinux.org.uk>
 <E1fKjEx-00063Y-N5@rmk-PC.armlinux.org.uk>
 <b454e37c-52a8-387f-3649-8ce72c9a5b18@gmail.com>
Message-ID: <20180525100359.GC17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 04:30:40PM -0700, Florian Fainelli wrote:
> On 05/21/2018 04:44 AM, Russell King wrote:
> > Check for CPU bugs when secondary processors are being brought online,
> > and also when CPUs are resuming from a low power mode.  This gives an
> > opportunity to check that processor specific bug workarounds are
> > correctly enabled for all paths that a CPU re-enters the kernel.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Something I missed, is that this correctly warns about e.g: missing the
> IBE bit for secondary cores, but it seems to be missing it for the boot CPU:

Are you sure that the boot CPU has the IBE bit clear?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
