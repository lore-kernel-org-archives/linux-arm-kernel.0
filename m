From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 6 Dec 2012 00:54:48 +0000
Subject: [v2 PATCH 2/8] watchdog/at91sam9_wdt: Convert to use the
 watchdog framework
In-Reply-To: <3976223.KImVV2lC5B@flexo>
References: <1354671267-19277-1-git-send-email-wenyou.yang@atmel.com>
 <1354671267-19277-3-git-send-email-wenyou.yang@atmel.com>
 <3976223.KImVV2lC5B@flexo>
Message-ID: <B256D81BAE5131468A838E5D7A2436413A01D599@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli at gmail.com] On Behalf Of Florian Fainelli
> Sent: 2012?12?5? 18:48
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; Ferre, Nicolas; plagnioj at jcrosoft.com; Lin,
> JM; wim at iguana.be; linux-watchdog at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: Re: [v2 PATCH 2/8] watchdog/at91sam9_wdt: Convert to use the watchdog
> framework
> 
> Hello Wenyou,
> 
> On Wednesday 05 December 2012 09:34:21 Wenyou Yang wrote:
> > According to the kernel document: convert_drivers_to_kernel_api.txt,
> > remove the file_operations struct, miscdevice, and obsolete includes
> >
> > Since the at91sam watchdog inherent characteristics, add the watchdog
> > operations: at91wdt_start, at91wdt_stop and at91wdt_ping.
> >
> 
> [snip]
> 
> >
> > +static inline bool watchdog_is_open(struct watchdog_device *wddev)
> > +{
> > +	return test_bit(WDOG_DEV_OPEN, &wddev->status);
> > +}
> 
> This helper should be moved to include/linux/watchdog.h as it can be useful
> for other watchdog drivers as well.

Thanks, I will move it in next version.

> --
> Florian

Best Regards
Wenyou Yang
