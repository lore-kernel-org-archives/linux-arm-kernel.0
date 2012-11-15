From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Nov 2012 17:20:25 -0800
Subject: [PATCH] ARM: OMAP4: PM: fix errata handling when CONFIG_PM=n
In-Reply-To: <1352940867-8806-1-git-send-email-khilman@deeprootsystems.com>
References: <1352940867-8806-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20121115012025.GE6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [121114 16:56]:
> From: Kevin Hilman <khilman@ti.com>
> 
> commit c9621844 (ARM: OMAP4: PM: add errata support) introduced errata
> handling for OMAP4, but was broken when CONFIG_PM=n.
> 
> When CONFIG_PM=n, pm44xx.c is not compiled, yet that is where pm44xx_errata
> is defined.  However, these errata are needed for the SMP boot/hotplug case
> also, and are primarily used in omap-smp.c.
> 
> Move the definition of pm44xx_errata to omap-smp.c so that it's available
> even in the CONFIG_PM=n case.
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> This patch applies on top of Tony's fixes-non-critical-part-2.
> The bug was introduced in my for_3.8-fixes-pm tag (now included in Tony's fixes-non-critical-part2.)

Thanks applied to omap-for-v3.8/fixes-non-critical-v2 and
pushed out.

Tony
