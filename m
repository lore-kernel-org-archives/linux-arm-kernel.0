From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Jun 2012 04:17:46 -0700
Subject: [RFC PATCH v2 03/11] mfd: omap: control: core system control
 driver
In-Reply-To: <4FE1DAA2.1000502@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <4FDF11C3.4010701@dev.rtsoft.ru>
 <20120620102224.GZ12766@atomide.com>
 <4FE1DAA2.1000502@dev.rtsoft.ru>
Message-ID: <20120626111746.GE31393@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120620 07:18]:
> 
> So,the same API set (omap_control_readl/omap_control_writel) was added to omap-control-core.c.
> 
> If omap-control-core.c should only service users from driver/ directory, than I agree - we can remove
> omap_control_readl/omap_control_writel from omap-control-core.c.
>   But IIUC you are agree to "switch" arch/arm/mach-omap2/id.c from control.c to omap-control-core.c. If arch/arm/mach-omap2/id.c is switched to control.c, then I guess all arch/arm/mach-omap2/*.c should be "switched" to omap-control-core.c as well. But this means that omap-control-core.c should provide omap_control_readl/omap_control_writel API.

Can't you just add something like int omap_ctrl_read_status(void)
that id.c can use?

Tony
