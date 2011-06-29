From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 22:45:45 +0100
Subject: [PATCH] OMAP3: run the ASM sleep code from DDR
In-Reply-To: <1309365623-14704-1-git-send-email-j-pihet@ti.com>
References: <1309365623-14704-1-git-send-email-j-pihet@ti.com>
Message-ID: <20110629214545.GH23312@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 06:40:23PM +0200, jean.pihet at newoldbits.com wrote:
> @@ -309,7 +308,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  
>  static void omap34xx_do_sram_idle(unsigned long save_state)
>  {
> -	_omap_sram_idle(omap3_arm_context, save_state);
> +	omap34xx_cpu_suspend(omap3_arm_context, save_state);

Actually, this should be called omap34xx_soc_suspend() or
omap34xx_finish_suspend() - finish_suspend() reflects the naming
of other such functions elsewhere.
