From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 31 May 2018 00:52:17 +0000
Subject: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle
 driver
In-Reply-To: <CAOMZO5BYgPu_T=_x8JDkj=k6TUmP0QEQmT8qxoMfxzyTgZrF7g@mail.gmail.com>
References: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
 <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BYgPu_T=_x8JDkj=k6TUmP0QEQmT8qxoMfxzyTgZrF7g@mail.gmail.com>
Message-ID: <AM3PR04MB13157285F0D882AD1C189617F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Wednesday, May 30, 2018 8:34 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> Estevam <fabio.estevam@nxp.com>; Russell King - ARM Linux
> <linux@armlinux.org.uk>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu
> idle driver
> 
> Hi Anson,
> 
> On Wed, May 30, 2018 at 4:12 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> > i.MX6SLL supports ARM power off in cpu idle, better to reuse i.MX6SX
> > cpu idle driver instead of i.MX6SL which does NOT support ARM power
> > off.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/mach-imx/cpuidle-imx6sl.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c
> > b/arch/arm/mach-imx/cpuidle-imx6sl.c
> > index fa8ead1..8d866fb 100644
> > --- a/arch/arm/mach-imx/cpuidle-imx6sl.c
> > +++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
> > @@ -12,7 +12,6 @@
> >
> >  #include "common.h"
> >  #include "cpuidle.h"
> > -#include "hardware.h"
> 
> The removal of this header file seems to be an unrelated change.
 
This header file is no longer needed since no " cpu_is_imx6sl()" used in this file.

Anson.
