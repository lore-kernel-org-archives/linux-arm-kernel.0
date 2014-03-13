From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 14:46:54 +0900
Subject: [PATCH 02/03] ARM: shmobile: Use shmobile_clk_workaround() on
 Lager
In-Reply-To: <CANqRtoR2UrJgw8mh-WFAOJR+0QKY0ZtjBW-gvh==YfUTjO81-w@mail.gmail.com>
References: <20140312233608.17009.65690.sendpatchset@w520>
 <20140312233626.17009.24749.sendpatchset@w520>
 <20140312235938.GF25813@verge.net.au>
 <20140313012344.GJ25813@verge.net.au>
 <CANqRtoR2UrJgw8mh-WFAOJR+0QKY0ZtjBW-gvh==YfUTjO81-w@mail.gmail.com>
Message-ID: <20140313054651.GA16074@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 02:14:57PM +0900, Magnus Damm wrote:
> On Thu, Mar 13, 2014 at 10:23 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Mar 13, 2014 at 08:59:45AM +0900, Simon Horman wrote:
> >> On Thu, Mar 13, 2014 at 08:36:26AM +0900, Magnus Damm wrote:
> >> > From: Magnus Damm <damm@opensource.se>
> >> >
> >> > Convert the Lager DT reference code to use the newly introduced
> >> > function shmobile_clk_workaround().
> >> >
> >> > Signed-off-by: Magnus Damm <damm@opensource.se>
> >> > ---
> >> >
> >> >  arch/arm/mach-shmobile/board-lager-reference.c |   65 +++++++++---------------
> >> >  1 file changed, 25 insertions(+), 40 deletions(-)
> >> >
> >> > --- 0001/arch/arm/mach-shmobile/board-lager-reference.c
> >> > +++ work/arch/arm/mach-shmobile/board-lager-reference.c     2014-02-24 16:17:32.000000000 +0900
> >> > @@ -18,12 +18,11 @@
> >> >   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >> >   */
> >> >
> >> > -#include <linux/clk.h>
> >> > -#include <linux/clkdev.h>
> >> >  #include <linux/dma-mapping.h>
> >> >  #include <linux/init.h>
> >> >  #include <linux/of_platform.h>
> >> >  #include <linux/platform_data/rcar-du.h>
> >> > +#include <mach/clock.h>
> >> >  #include <mach/common.h>
> >> >  #include <mach/irqs.h>
> >> >  #include <mach/rcar-gen2.h>
> >> > @@ -86,46 +85,32 @@ static void __init lager_add_du_device(v
> >> >     platform_device_register_full(&info);
> >> >  }
> >> >
> >> > +/*
> >> > + * This is a really crude hack to provide clkdev support to platform
> >> > + * devices until they get moved to DT.
> >> > + */
> >> > +static const struct clk_name clk_names[] = {
> >>
> >> Should this be annotated as __initconst?
> >> Likewise for the Koelsch variant of this patch.
> >
> > Btw, I'm happy to handle this as an incremental patch if you like.
> 
> Yes, that would be greatly appreciated!

Thanks, I have queued it up.
