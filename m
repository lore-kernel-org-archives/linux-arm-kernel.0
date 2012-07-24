From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 24 Jul 2012 12:04:30 +0000
Subject: [PATCH 2/6] ARM: davinci: remove rtc kicker release
In-Reply-To: <500E82D4.9090702@mvista.com>
References: <cover.1343046707.git.afzal@ti.com>
 <f9e348c8cb7402b27b1a5633b06620266e369641.1343046707.git.afzal@ti.com>
 <500E82D4.9090702@mvista.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9AD19E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Tue, Jul 24, 2012 at 16:41:16, Sergei Shtylyov wrote:

> >   static struct platform_device da8xx_rtc_device = {
> > -	.name           = "omap_rtc",
> > +	.name           = "am1808-rtc",
> 
>     Why not "da8xx-rtc". Kick registers exist startting with 
> DA830/OMAP-L137/AM1707, not only on AM1808.

I would prefer to keep da830-rtc, even though it is not strictly
a requirement; "da830-rtc" could be used for DT case too (as in
DT, wild card compatibles are not recommended), hence allowing
us to have a uniform name for DT & non-DT case.

Regards
Afzal
