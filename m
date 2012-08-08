From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 Aug 2012 07:23:10 -0700
Subject: [PATCH] omap: Fix multi.h when only ARCH_OMAP3 and SOC_AM33XX
 are selected
In-Reply-To: <1344356985-21801-1-git-send-email-jlu@pengutronix.de>
References: <1344356985-21801-1-git-send-email-jlu@pengutronix.de>
Message-ID: <20120808142309.GH11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jan Luebbe <jlu@pengutronix.de> [120807 09:30]:
> When only ARCH_OMAP3 (or -2,-4,...) and SOC_AM33XX are selected, multi.h
> doesn't set MULTI_OMAP2. In this case, cpu.h will simply define
> cpu_is_omap24xx() as 1.
> 
> This causes problems for example for omap_hwmod.c:omap_hwmod_init which
> checks for cpu_is_omap24xx() first, using the wrong soc_ops for AM33xx.
> 
> Fix this by defining MULTI_OMAP2 when using SOC_AM33XX together with
> something else.

Thanks applying into fixes.

Tony
