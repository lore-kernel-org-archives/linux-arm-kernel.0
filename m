From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Jul 2014 17:01:13 +0100
Subject: [PATCH] irqchip: gic-v3: Only define gic_peek_irq() when building
 SMP
In-Reply-To: <1406480224-24628-1-git-send-email-broonie@kernel.org>
References: <1406480224-24628-1-git-send-email-broonie@kernel.org>
Message-ID: <53D673C9.2070005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/07/14 17:57, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> If building with CONFIG_SMP disbled (for example, with allnoconfig) then
> GCC complains that the static function gic_peek_irq() is defined but not
> used since the only reference is in the SMP initialisation code. Fix this
> by moving the function definition inside the ifdef.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Looks sane to me.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
