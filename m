From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Feb 2013 12:38:32 +0000
Subject: [PATCH 3/9] ARM: omap2: include linux/errno.h in hwmod_reset
In-Reply-To: <20130214225142.GG11362@atomide.com>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-4-git-send-email-arnd@arndb.de>
 <20130214225142.GG11362@atomide.com>
Message-ID: <201302151238.32316.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 February 2013, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [130214 14:51]:
> > The newly created omap_hwmod_reset.c is missing an
> > include of linux/errno.h in commit c02060d8 "ARM:
> > OMAP4+: AESS: enable internal auto-gating during
> > initial setup". It still works in omap2_defconfig,
> > but not in all other combinations.
> > 
> > Without this patch, building allmodconfig results in:
> > 
> > arch/arm/mach-omap2/omap_hwmod_reset.c: In function 'omap_hwmod_aess_preprogram':
> > arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: error: 'EINVAL' undeclared (first use in this function)
> > arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: note: each undeclared identifier is reported only once for each function it appears in
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Sebastien Guiriec <s-guiriec@ti.com>
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Ok, applied on top of late/omap

	Arnd
