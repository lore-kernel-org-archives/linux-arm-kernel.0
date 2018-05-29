From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 May 2018 11:51:32 -0400 (EDT)
Subject: [PATCH] ARM: mcpm, perf/arm-cci: export mcpm_is_available
In-Reply-To: <20180529153013.GH17159@arm.com>
References: <20180528154448.2494709-1-arnd@arndb.de>
 <20180529153013.GH17159@arm.com>
Message-ID: <nycvar.YSQ.7.76.1805291150330.1473@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 May 2018, Will Deacon wrote:

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

Looks fine to me.

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas
