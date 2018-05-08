From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 8 May 2018 09:07:59 +0100
Subject: [PATCH v9 07/12] ARM: sunxi: Add initialization of CNTVOFF
In-Reply-To: <20180504190545.5114-8-mylene.josserand@bootlin.com>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
 <20180504190545.5114-8-mylene.josserand@bootlin.com>
Message-ID: <71a9026d-1327-4948-5729-8d10cb7415f9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/18 20:05, Myl?ne Josserand wrote:
> Add the initialization of CNTVOFF for sun8i-a83t.
> 
> For boot CPU, create a new machine that handles this
> function's call in an "init_early" callback. We need to initialize
> CNTVOFF before the arch timer's initialization otherwise, it will
> not be taken into account and fails to boot correctly.
> Because of that, this function can't be called in SMP's early_initcall
> function which is called after timer's init.
> 
> For secondary CPUs, add this function into secondary_startup
> assembly entry.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
