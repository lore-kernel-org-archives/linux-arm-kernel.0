From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 May 2018 16:41:20 +0100
Subject: [PATCH] ARM: mcpm, perf/arm-cci: export mcpm_is_available
In-Reply-To: <20180529153324.GL17671@n2100.armlinux.org.uk>
References: <20180528154448.2494709-1-arnd@arndb.de>
 <20180529153013.GH17159@arm.com>
 <20180529153324.GL17671@n2100.armlinux.org.uk>
Message-ID: <20180529154120.GI17159@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, May 29, 2018 at 04:33:24PM +0100, Russell King - ARM Linux wrote:
> On Tue, May 29, 2018 at 04:30:14PM +0100, Will Deacon wrote:
> > Hi Arnd, Russell, [+Nico and Robin]
> > 
> > On Mon, May 28, 2018 at 05:44:36PM +0200, Arnd Bergmann wrote:
> > > Now that the ARM CCI PMU driver can be built as a loadable module,
> > > we get a link failure when MCPM is enabled:
> > > 
> > > ERROR: "mcpm_is_available" [drivers/perf/arm-cci.ko] undefined!
> > > 
> > > The simplest fix is to export that helper function.
> > > 
> > > Fixes: 8b0c93c20ef7 ("perf/arm-cci: Allow building as a module")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > The patch that caused this is currently part of the arm-perf/for-next/perf
> > > branch, it would be good to have the fix there as well.
> > > ---
> > >  arch/arm/common/mcpm_entry.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > I'm happy to take this via the arm perf tree if others are ok with that.
> > Alternatively, I can revert the offending commit if there are objections
> > to exporting the symbol.
> > 
> > Russell: do you any preference?
> 
> As it claims to fix 8b0c93c20ef7, which I don't have, I can't take this
> patch.  Do we know which tree has this?

Yes, sorry, it's in my for-next/perf branch:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-next/perf&id=8b0c93c20ef78f15d8b760964ff79bda7f68c610

which is now in -next.

I'm happy to take the mcpm patch on top with your ack, but if you have
conflicting changes (or would prefer not to export the symbol to modules)
then I can just revert the patch in my tree for now.

Will
