From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Thu, 12 Sep 2013 17:03:19 +0300
Subject: [PATCH 1/2] ARM: msm: Add support for MSM8974 Dragonboard
In-Reply-To: <20130911181226.GU808@joshc.qualcomm.com>
References: <1375743779-24993-1-git-send-email-rvaswani@codeaurora.org>
 <1375780486.2725.7.camel@iivanov-dev.int.mm-sol.com>
 <20130911181226.GU808@joshc.qualcomm.com>
Message-ID: <1378994599.16481.4.camel@iivanov-dev.int.mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, 

On Wed, 2013-09-11 at 13:12 -0500, Josh Cartwright wrote: 
> Hey Ivan-
> 
> On Tue, Aug 06, 2013 at 12:14:46PM +0300, Ivan T. Ivanov wrote:
> [..]
> > Enable low-level debug print routines to direct their
> > output to the serial port on MSM 8974 devices.
> > 
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> > ---
> >  arch/arm/Kconfig.debug                     |    8 ++++++++
> >  arch/arm/mach-msm/board-dt-8974.c          |    2 ++
> >  arch/arm/mach-msm/include/mach/msm_iomap.h |    4 ++++
> >  3 files changed, 14 insertions(+)
> [..]
> > diff --git a/arch/arm/mach-msm/board-dt-8974.c b/arch/arm/mach-msm/board-dt-8974.c
> > index 697623e..0ce016a 100644
> > --- a/arch/arm/mach-msm/board-dt-8974.c
> > +++ b/arch/arm/mach-msm/board-dt-8974.c
> > @@ -12,6 +12,7 @@
> >  
> >  #include <linux/of_platform.h>
> >  #include <asm/mach/arch.h>
> > +#include <asm/mach/map.h>
> >  
> >  static const char * const msm8974_dt_match[] __initconst = {
> >  	"qcom,msm8974-db",
> > @@ -20,4 +21,5 @@ static const char * const msm8974_dt_match[] __initconst = {
> >  
> >  DT_MACHINE_START(MSM8974_DT, "Qualcomm MSM (Flattened Device Tree)")
> >  	.dt_compat = msm8974_dt_match,
> > +	.map_io = debug_ll_io_init,
> 
> If/when you get this patch cooked up ontop of Rohit's, changes to this
> file (renamed to board-dt.c) should not be necessary.  As of bc37324
> ("ARM: mmu: Call debug_ll_io_init if no map_io function is specified"),
> the debug ll uart mapping is setup automatically.

Thanks Josh. I am aware of this.

Regards,
Ivan


> 
> Thanks,
>   Josh
> 
