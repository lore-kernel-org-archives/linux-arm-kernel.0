From: jgq516@gmail.com (xiao jiang)
Date: Tue, 19 Oct 2010 09:50:07 +0800
Subject: [PATCH 1/1] Mx35pdk: enable debug board support
In-Reply-To: <AANLkTi=jyQDNmGK1-VB_xOP8H4+jXNwS6oHgft90gGLW@mail.gmail.com>
References: <1287129633-9244-1-git-send-email-jgq516@gmail.com>
	<AANLkTikY=wBiJZ0NFKJKX-TTKRAj_LWmaxD-BpuPNYzL@mail.gmail.com>
	<AANLkTi=jyQDNmGK1-VB_xOP8H4+jXNwS6oHgft90gGLW@mail.gmail.com>
Message-ID: <AANLkTim65XWxn_Mc59PXbiOOqUVMDNqeweU38y_3R7_X@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

2010/10/19 Fabio Estevam <festevam@gmail.com>

> Hi Xiao,
>
> 2010/10/18 xiao jiang <jgq516@gmail.com>:
> > Hi Uwe & Fabio,
> >
> > 2010/10/15 <jgq516@gmail.com>
> >>
> >> From: Xiao Jiang <jgq516@gmail.com>
> >>
> >> Add debug board support, then kernel can boot from lan9217 ethernet.
> >>
> >> Signed-off-by: Xiao Jiang <jgq516@gmail.com>
> >> ---
> >>  arch/arm/mach-mx3/mach-mx35_3ds.c          |    9 +++++++++
> >>  arch/arm/plat-mxc/include/mach/iomux-mx3.h |    4 ++++
> >>  2 files changed, 13 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c
> >> b/arch/arm/mach-mx3/mach-mx35_3ds.c
> >> index 1c30d72..78e0657 100644
> >> --- a/arch/arm/mach-mx3/mach-mx35_3ds.c
> >> +++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
> >> @@ -34,11 +34,16 @@
> >>
> >>  #include <mach/hardware.h>
> >>  #include <mach/common.h>
> >> +#include <mach/irqs.h>
> >> +#include <mach/iomux-mx3.h>
>
> You don't need to add this.
>
> >>  #include <mach/iomux-mx35.h>
> >> +#include <mach/3ds_debugboard.h>
> >>
> >>  #include "devices-imx35.h"
> >>  #include "devices.h"
> >>
> >> +#define EXPIO_PARENT_INT       IOMUX_TO_IRQ(MX35_PIN_GPIO1_1)
>
> Why don't you use MX35_PAD_GPIO1_1__GPIO1_1 instead which is already
> defined at:
> arch/arm/plat-mxc/include/mach/iomux-mx35.h ?
>
>
> I tried to use  MX35_PAD_GPIO1_1__GPIO1_1, but there isn't function to
transform to irq num, so I added
the pin definition in iomux-mx3.h. Is there any function can transform the
PAD to irq num?

Only board-mx51_3ds.c & mach-mx31_3ds.c which called mxc_expio_init
function,  and I followed the rule of mach-mx31_3ds.c. Is it ok to change
style like mx51_3ds as follows?
#define EXPIO_PARENT_INT        (MXC_INTERNAL_IRQS + GPIO_PORTA + 6)

Also, look at how MX31-3stack implemented the debug board support and
> pass MXC_DEBUG_BOARD in the Kconfig.
>
> Got it, will add it

> >
> > Any comments? And I can't the sdma driver in arch/arm/plat-mxc/ which is
> > used by lots of i.mx chips, is somebody planing to do it or
> > it will going to mainline soon ?
>
> Sascha submitted initial support patches for i.MX SDMA.
>
> That is great!

Thanks
Xiao Jiang

> Regards,
>
> Fabio Estevam
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101019/4503b7a5/attachment-0001.html>
