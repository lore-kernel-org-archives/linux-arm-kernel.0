From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 14 Feb 2013 22:58:49 +0000 (UTC)
Subject: [PATCH 3/9] ARM: omap2: include linux/errno.h in hwmod_reset
In-Reply-To: <1360882071-4072668-4-git-send-email-arnd@arndb.de>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-4-git-send-email-arnd@arndb.de>
Message-ID: <alpine.DEB.2.00.1302142258390.11016@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Feb 2013, Arnd Bergmann wrote:

> The newly created omap_hwmod_reset.c is missing an
> include of linux/errno.h in commit c02060d8 "ARM:
> OMAP4+: AESS: enable internal auto-gating during
> initial setup". It still works in omap2_defconfig,
> but not in all other combinations.
> 
> Without this patch, building allmodconfig results in:
> 
> arch/arm/mach-omap2/omap_hwmod_reset.c: In function 'omap_hwmod_aess_preprogram':
> arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: error: 'EINVAL' undeclared (first use in this function)
> arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: note: each undeclared identifier is reported only once for each function it appears in

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
