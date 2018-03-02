From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Fri, 2 Mar 2018 09:55:43 +0000
Subject: [PATCH 2/3] staging: fsl-mc: Move DPBP out of staging
In-Reply-To: <5A9916C0.6090804@nxp.com>
References: <20180301174712.2660-1-bogdan.purcareata@nxp.com>
 <20180301174712.2660-3-bogdan.purcareata@nxp.com> <5A9916C0.6090804@nxp.com>
Message-ID: <AM0PR0402MB364957B0E5A21228C1D8BD1DEAC50@AM0PR0402MB3649.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Laurentiu Tudor
> Sent: Friday, March 02, 2018 11:18 AM
> To: Bogdan Purcareata <bogdan.purcareata@nxp.com>; gregkh at linuxfoundation.org;
> Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
> Cc: stuyoder at gmail.com; Ioana Ciornei <ioana.ciornei@nxp.com>; Nipun Gupta
> <nipun.gupta@nxp.com>; Roy Pledge <roy.pledge@nxp.com>; Horia Geant?
> <horia.geanta@nxp.com>; devel at driverdev.osuosl.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/3] staging: fsl-mc: Move DPBP out of staging
> 
> Hi Bogdan,
> 
> On 03/01/2018 07:47 PM, Bogdan Purcareata wrote:
> > Move the source files out of staging into their final locations:
> > - dpbp.c goes to drivers/bus/fsl-mc/, next to the core infrastructure
> > - dpbp-cmd.h gets merged into drivers/bus/fsl-mc/fsl-mc-private.h, next
> >    to the other internally used APIs
> > - dpbp.h gets merged into include/linux/fsl/mc.h, exposing the public
> >    API
> >
> > Update references in the dpaa2-eth staging driver.
> >
> > DPBP stands for Data Path Buffer Pool - you can read more about the
> > object in Documentation/networking/dpaa2/overview.rst
> >
> > Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
> > ---
> >   drivers/bus/fsl-mc/Makefile                       |  1 +
> >   drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c |  4 +-
> >   drivers/bus/fsl-mc/fsl-mc-private.h               | 39 +++++++++++++++++
> >   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h    |  2 +-
> >   drivers/staging/fsl-mc/bus/Makefile               |  3 +-
> >   drivers/staging/fsl-mc/bus/dpbp-cmd.h             | 44 -------------------
> >   drivers/staging/fsl-mc/include/dpbp.h             | 53 --------------------
> ---
> >   include/linux/fsl/mc.h                            | 42 ++++++++++++++++++
> >   8 files changed, 86 insertions(+), 102 deletions(-)
> >   rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (98%)
> >   delete mode 100644 drivers/staging/fsl-mc/bus/dpbp-cmd.h
> >   delete mode 100644 drivers/staging/fsl-mc/include/dpbp.h
> >
> > diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
> > index 6a97f2c..da26e52 100644
> > --- a/drivers/bus/fsl-mc/Makefile
> > +++ b/drivers/bus/fsl-mc/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
> >   mc-bus-driver-objs := fsl-mc-bus.o \
> >   		      mc-sys.o \
> >   		      mc-io.o \
> > +		      dpbp.o \
> >   		      dprc.o \
> >   		      dprc-driver.o \
> >   		      fsl-mc-allocator.o \
> > diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
> > similarity index 98%
> > rename from drivers/staging/fsl-mc/bus/dpbp.c
> > rename to drivers/bus/fsl-mc/dpbp.c
> > index 85735bb..31a360b 100644
> > --- a/drivers/staging/fsl-mc/bus/dpbp.c
> > +++ b/drivers/bus/fsl-mc/dpbp.c
> > @@ -5,9 +5,9 @@
> >    */
> >   #include <linux/kernel.h>
> >   #include <linux/fsl/mc.h>
> > -#include "../include/dpbp.h"
> > +#include "linux/fsl/mc.h"
> 
> I think we can use <> here, same comment for patch 3/3.
> 
> Other than that, the series looks ok to me so for all the patches:
> 
> Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Thank you!
I will update the patchset - seeing that the cleanup one has already been applied - and will send a v2 shortly.

Best regards,
Bogdan
