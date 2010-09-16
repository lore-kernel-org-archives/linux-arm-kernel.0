From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Sep 2010 10:53:18 -0700
Subject: [PATCH 1/5] omap3: Introduce CompuLab CM-T3517 module.
In-Reply-To: <1284627281-26059-2-git-send-email-grinberg@compulab.co.il>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
	<1284627281-26059-2-git-send-email-grinberg@compulab.co.il>
Message-ID: <20100916175317.GF29610@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [100916 01:46]:
> Add basic suppot, enable uart and led.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-omap2/Kconfig          |    7 ++
>  arch/arm/mach-omap2/Makefile         |    1 +
>  arch/arm/mach-omap2/board-cm-t3517.c |  109 ++++++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-cm-t3517.c

Looks like you're missing the debug uart entry for
arch/arm/plat-omap/include/plat/uncompress.h?

You can test this by enabling DEBUG_LL and EARLY_PRINTK
in your .config, then pass earlyprintk in the kernel
cmdline. Might become handy for debugging the early
init process for your board.

Regards,

Tony
