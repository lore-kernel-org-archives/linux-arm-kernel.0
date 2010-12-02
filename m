From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Dec 2010 11:59:57 -0800
Subject: [PATCH v4 02/13] OMAP: DMA: Introduce errata handling feature
In-Reply-To: <1289225272-9767-3-git-send-email-manjugk@ti.com>
References: <1289225272-9767-1-git-send-email-manjugk@ti.com>
	<1289225272-9767-3-git-send-email-manjugk@ti.com>
Message-ID: <20101202195957.GU17222@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* G, Manjunath Kondaiah <manjugk@ti.com> [101108 05:58]:
> Implement errata handling to use flags instead of cpu_is_*
> and cpu_class_* in the code.
> 
> The errata flags are initialized at init time and during runtime
> we are using the errata variable (via the IS_DMA_ERRATA macro)
> to execute the required errata workaround.

Applying the first patch and this patch won't compile on omap1:

arch/arm/plat-omap/built-in.o: In function `omap_init_dma':
omap-pm-noop.c:(.init.text+0x604): undefined reference to `omap_type'

Tony
