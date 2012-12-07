From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 7 Dec 2012 07:12:54 +0000
Subject: [v2 PATCH 6/8] watchdog/at91sam9_wdt: Use module_platform_driver()
In-Reply-To: <50C0E0E8.3020809@mvista.com>
References: <1354671267-19277-1-git-send-email-wenyou.yang@atmel.com>
 <1354671267-19277-7-git-send-email-wenyou.yang@atmel.com>
 <50C0E0E8.3020809@mvista.com>
Message-ID: <B256D81BAE5131468A838E5D7A2436413A01DF81@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov at mvista.com]
> Sent: 2012?12?7? 2:16
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; linux-watchdog at vger.kernel.org; Lin, JM;
> Ferre, Nicolas; linux-kernel at vger.kernel.org; wim at iguana.be;
> plagnioj at jcrosoft.com
> Subject: Re: [v2 PATCH 6/8] watchdog/at91sam9_wdt: Use
> module_platform_driver()
> 
> Hello.
> 
> On 12/05/2012 04:34 AM, Wenyou Yang wrote:
> 
> > Using module_platform_driver() replaces module_init() and module_exit()
> > and makes the code simpler.
> 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Cc: wim at iguana.be
> > Cc: linux-watchdog at vger.kernel.org
> > Cc: linux-kernel at vger.kernel.org
> > ---
> >  drivers/watchdog/at91sam9_wdt.c |   14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> > index 5afd3fb..a7c0881 100644
> > --- a/drivers/watchdog/at91sam9_wdt.c
> > +++ b/drivers/watchdog/at91sam9_wdt.c
> > @@ -278,6 +278,7 @@ MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
> >  #endif
> >
> >  static struct platform_driver at91wdt_driver = {
> > +	.probe		= at91wdt_probe,
> 
>    You also need to remove '__init' annotation from that function since the
> driver becomes hot-plug aware now.
Thanks, I got it.
> 
> WBR, Sergei

Best Regards,
Wenyou Yang
