From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 31 Jan 2013 08:24:00 +0000
Subject: [PATCH v3] ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL
 check" bug
In-Reply-To: <D0DE2843-AA5C-4DFA-ADBE-61BC11D24836@dominion.thruhere.net>
References: <1359556760-25214-1-git-send-email-gururaja.hebbar@ti.com>
 <D0DE2843-AA5C-4DFA-ADBE-61BC11D24836@dominion.thruhere.net>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB59E84@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:58:36, Koen Kooi wrote:
> 
> Op 30 jan. 2013, om 15:39 heeft Hebbar Gururaja <gururaja.hebbar@ti.com> het volgende geschreven:
> 
> > am33xx_cm_wait_module_ready() checks if register offset is NULL.
> > 
> > int am33xx_cm_wait_module_ready(u16 inst, s16 cdoffs, u16 clkctrl_offs)
> > {
> > 	int i = 0;
> > 
> > 	if (!clkctrl_offs)
> > 		return 0;
> > 
> > In case of AM33xx, CLKCTRL register offset for different clock domains
> > are not uniformly placed. An example of this would be the RTC clock
> > domain with CLKCTRL offset at 0x00.
> > In such cases the module ready check is skipped which leads to a data
> > abort during boot-up when RTC registers is accessed.
> > 
> > Remove this check here to avoid checking module readiness for modules
> > with clkctrl register offset at 0x00.
> > 
> > Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> 
> I can confirm that this fixes the crash on boot with CONFIG_RTC_DRV_OMAP=y with 3.8-rc5

Could you please share the crash log for my reference?

> 
> regards,
> 
> Koen


Regards, 
Gururaja
