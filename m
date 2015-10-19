From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 19 Oct 2015 17:41:30 +0100
Subject: [PATCH] ARM: imx: support edge irq trigger for gpc
In-Reply-To: <1445274132-12253-1-git-send-email-b20788@freescale.com>
References: <1445274132-12253-1-git-send-email-b20788@freescale.com>
Message-ID: <20151019174130.206abbee@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Oct 2015 01:02:12 +0800
Anson Huang <b20788@freescale.com> wrote:

> GPC irq domain is a child domain of GIC, now all of
> platform irqs are inside GPC domain, during the module
> populate, all devices irq should have correct type
> setting in GIC, however, there is no .irq_set_type
> callback setting in GPC, so the irq_set_type will be
> skipped and cause edge raising type of irq work
> abnormally after kernel boot up.
> 
> Since GPC has no irq type, so just tell kernel to
> use irq_chip_set_type_parent instead.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Looks good to me.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
