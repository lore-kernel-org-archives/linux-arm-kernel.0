From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 26 Mar 2010 08:54:52 +0100
Subject: [PATCH 2/3] imx3: Add rtc platform device support
In-Reply-To: <87d3yshbuo.fsf@vovsem.com>
References: <1269430338-22690-1-git-send-email-vzapolskiy@gmail.com>
	<1269430338-22690-2-git-send-email-vzapolskiy@gmail.com>
	<20100325073537.GZ2241@pengutronix.de> <87d3yshbuo.fsf@vovsem.com>
Message-ID: <20100326075452.GD2241@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 02:36:31PM +0300, Vladimir Zapolskiy wrote:
> Hi Sasha,
> 
> >
> > On Wed, Mar 24, 2010 at 02:32:17PM +0300, Vladimir Zapolskiy wrote:
> >> This patch adds support for build-in RTC device found on
> >> Freescale imx31 and imx35 SoCs.
> >> 
> >> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> >> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> >> ---
> >>  arch/arm/mach-mx3/devices.c |   19 +++++++++++++++++++
> >>  arch/arm/mach-mx3/devices.h |    1 +
> >>  2 files changed, 20 insertions(+), 0 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
> >> index f891115..1ffed28 100644
> >> --- a/arch/arm/mach-mx3/devices.c
> >> +++ b/arch/arm/mach-mx3/devices.c
> >> @@ -588,6 +588,25 @@ struct platform_device imx_wdt_device0 = {
> >>  	.resource       = imx_wdt_resources,
> >
> > This patch does not apply. We do not have the watchdog in devices.c atm.
> >
> 
> please could you suggest the appropriate branch, because this patch is
> based on mxc-master branch, where the watchdog is already pushed, see
> http://git.pengutronix.de/?p=imx/linux-2.6.git;a=shortlog;h=refs/heads/mxc-master

Oh, my bad. I myself tried to push it on master and not on mxc-master.

> 
> >>  };
> >>  
> >> +static struct resource imx_rtc_resources[] = {
> >> +	{
> >> +		.start  = MX31_RTC_BASE_ADDR,
> >> +		.end    = MX31_RTC_BASE_ADDR + 0x3fff,
> >> +		.flags  = IORESOURCE_MEM,
> >> +	},
> >> +	{
> >> +		.start  = MX31_INT_RTC,
> >> +		.flags  = IORESOURCE_IRQ,
> >> +	},
> >
> > Can you provide a fixup for i.MX35, please? See mx3_devices_init().
> 
> Surely. Before patch submission I just checked that base address, size
> and interrupt number are equal for i.MX31 and i.MX35 SoCs, and I've
> found that in such cases the resources are defined using MX31 macros,
> see imx_ssi_resources or mxc_usbhX_resources as reference.

Ok. I just saw that there are two defines without checking that they are
actually identical.

> 
> Probably better to separate the devices.c file into two files? You see
> one day I hope i.MX37 support will be included into the Linux kernel,
> and it would be quite uncomfortable to support three kinds of peripheral
> in a single file.

We are already working on seperating them. Have a look at the i.MX21/27
devices.c.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
