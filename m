From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 Jul 2013 23:35:13 -0700
Subject: [PATCHv4 29/33] CLK: omap: add omap3 clock init file
In-Reply-To: <51F81FD7.2060707@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-30-git-send-email-t-kristo@ti.com>
 <51F81FD7.2060707@ti.com>
Message-ID: <20130731063512.GP7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [130730 13:26]:
> On 07/23/2013 02:20 AM, Tero Kristo wrote:
> >clk-3xxx.c now contains the clock init functionality for omap3, including
> >DT clock registration and adding of static clkdev entries.
> >
> >This patch also splits the OMAP3 clock registration code under mach-omap2
> >to use OMAP3 subtype specific clk init functions.
> >
> >Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >---
> >  arch/arm/mach-omap2/Makefile          |    2 +-
> >  arch/arm/mach-omap2/cclock3xxx_data.c | 3641 ---------------------------------
> 
> Tony and a lot of people is not going to like removing support for
> non-dt boot for OMAP3 before "it's time is due" ;)

I think the only showstopper for that is that we need the
pending pinctrl changes merged first to keep off-idle working.
So the omap3 legacy code removal probably needs to wait until
v3.13 merge window. For omap4 and am33xx we can do it now.

Regards,

Tony
