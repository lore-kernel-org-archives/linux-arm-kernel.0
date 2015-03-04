From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 4 Mar 2015 09:48:33 -0800
Subject: [PATCH v3 3/9] watchdog: at91rm9200: use the system timer syscon
In-Reply-To: <20150304150815.GG3989@piout.net>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425478897-27322-4-git-send-email-alexandre.belloni@free-electrons.com>
 <54F71C07.6070204@roeck-us.net> <20150304150815.GG3989@piout.net>
Message-ID: <20150304174826.GA5568@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 04:08:15PM +0100, Alexandre Belloni wrote:
> On 04/03/2015 at 06:51:51 -0800, Guenter Roeck wrote :
> > >@@ -267,7 +276,7 @@ static struct platform_driver at91wdt_driver = {
> > >  	.suspend	= at91wdt_suspend,
> > >  	.resume		= at91wdt_resume,
> > >  	.driver		= {
> > >-		.name	= "at91_wdt",
> > >+		.name	= "atmel_st_watchdog",
> > 
> > If you change the driver name you also need to change the MODULE_ALIAS
> > a few lines down.
> > 
> > But why change it in the first place ? Maybe that was discussed somewhere,
> > but not here where it belongs, and not in patch 0/9 either.
> > 
> 
> That's because it conflicts with drivers/watchdog/at91sam9_wdt.c
> 
You still have to update MODULE_ALIAS (or drop it if it is not needed anymore).

Guenter

> I'm not sure that is relevant anymore as they will only be probed using
> DT now.
> 
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
