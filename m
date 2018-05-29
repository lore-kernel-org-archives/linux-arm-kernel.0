From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2018 16:33:24 +0100
Subject: [PATCH] ARM: mcpm, perf/arm-cci: export mcpm_is_available
In-Reply-To: <20180529153013.GH17159@arm.com>
References: <20180528154448.2494709-1-arnd@arndb.de>
 <20180529153013.GH17159@arm.com>
Message-ID: <20180529153324.GL17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 04:30:14PM +0100, Will Deacon wrote:
> Hi Arnd, Russell, [+Nico and Robin]
> 
> On Mon, May 28, 2018 at 05:44:36PM +0200, Arnd Bergmann wrote:
> > Now that the ARM CCI PMU driver can be built as a loadable module,
> > we get a link failure when MCPM is enabled:
> > 
> > ERROR: "mcpm_is_available" [drivers/perf/arm-cci.ko] undefined!
> > 
> > The simplest fix is to export that helper function.
> > 
> > Fixes: 8b0c93c20ef7 ("perf/arm-cci: Allow building as a module")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > The patch that caused this is currently part of the arm-perf/for-next/perf
> > branch, it would be good to have the fix there as well.
> > ---
> >  arch/arm/common/mcpm_entry.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> I'm happy to take this via the arm perf tree if others are ok with that.
> Alternatively, I can revert the offending commit if there are objections
> to exporting the symbol.
> 
> Russell: do you any preference?

As it claims to fix 8b0c93c20ef7, which I don't have, I can't take this
patch.  Do we know which tree has this?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
