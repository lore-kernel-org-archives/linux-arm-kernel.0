From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 30 Jan 2013 16:42:22 +0000 (UTC)
Subject: [PATCH v3] ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL
 check" bug
In-Reply-To: <1359556760-25214-1-git-send-email-gururaja.hebbar@ti.com>
References: <1359556760-25214-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <alpine.DEB.2.00.1301301641490.17105@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jan 2013, Hebbar Gururaja wrote:

> am33xx_cm_wait_module_ready() checks if register offset is NULL.
> 
> int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
> {
> 	int i = 0;
> 
> 	if (!clkctrl_offs)
> 		return 0;
> 
> In case of AM33xx, CLKCTRL register offset for different clock domains
> are not uniformly placed. An example of this would be the RTC clock
> domain with CLKCTRL offset at 0x00.
> In such cases the module ready check is skipped which leads to a data
> abort during boot-up when RTC registers is accessed.
> 
> Remove this check here to avoid checking module readiness for modules
> with clkctrl register offset at 0x00.
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>

See 

http://marc.info/?l=linux-omap&m=135956399407076&w=2


- Paul
