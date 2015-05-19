From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Tue, 19 May 2015 15:12:23 +0530
Subject: [PATCH v1 2/2] ARM: vf610: Add SoC bus support for Vybrid
In-Reply-To: <20150519062413.GR1071@dragon>
References: <cover.1431928866.git.maitysanchayan@gmail.com>
 <653ed53ef933a6834c4fd3c90ee47e5fb5c78160.1431928866.git.maitysanchayan@gmail.com>
 <20150519062413.GR1071@dragon>
Message-ID: <20150519094223.GA3194@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On 15-05-19 14:24:13, Shawn Guo wrote:
> On Mon, May 18, 2015 at 11:50:07AM +0530, Sanchayan Maity wrote:
> > Implements SoC bus support to export SoC specific information. Read
> > the unique SoC ID from the Vybrid On Chip One Time Programmable
> > (OCOTP) controller, SoC specific information from the Miscellaneous
> > System Control Module (MSCM), revision from the ROM revision register
> > and expose it via the SoC bus infrastructure.
> > 
> > Sample Output:
> > 
> > root at vf:/sys/devices/soc0# cat soc_id
> > df63c12a2e2161d4
> > root at vf:/sys/devices/soc0# cat family
> > Freescale Vybrid VF500
> > root at vf:/sys/devices/soc0# cat revision
> > 00000013
> > root at vf:/sys/devices/soc0# cat machine
> > Freescale Vybrid
> > 
> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > ---
> >  arch/arm/mach-imx/mach-vf610.c | 81 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> > 
> > diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
> > index 2e7c75b..64c78e4 100644
> > --- a/arch/arm/mach-imx/mach-vf610.c
> > +++ b/arch/arm/mach-imx/mach-vf610.c
> > @@ -11,6 +11,86 @@
> >  #include <linux/irqchip.h>
> >  #include <asm/mach/arch.h>
> >  #include <asm/hardware/cache-l2x0.h>
> > +#include <linux/slab.h>
> > +#include <linux/sys_soc.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> > +#include <linux/random.h>
> 
> Please group <linux/*> headers together and sort alphabetically.

Ok. Will fix this and send out a v2. The rest is acceptable?

> 
> Shawn

Thanks & Regards,
Sanchayan Maity.
