From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Feb 2018 13:11:08 +0000
Subject: [PATCH] drm/rockchip: Set IRQ_NOAUTOEN flag before requesting the
 interrupt
In-Reply-To: <20180210142020.30212-1-marc.zyngier@arm.com>
References: <20180210142020.30212-1-marc.zyngier@arm.com>
Message-ID: <249356f0-34a8-4fba-6102-dfe9e658ed6d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/18 14:20, Marc Zyngier wrote:
> Calling request_irq() followed by disable_irq() is usually a bad idea,
> specially if the interrupt can be pending, and you're not yet in a
> position to handle it.
> 
> This is exactly what happens on my kevin system when rebooting in a
> second kernel using kexec: Some interrupt is left pending from
> the previous kernel, and we take it too early, before disable_irq()
> could do anything.
> 
> A better way of ensuring safety is to set the IRQ_NOAUTOEN flag
> on the irq before requesting it.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

For the record, I've posted a (much) improved version of this as part of
a series here[1].

Thanks,

	M.

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/560703.html
-- 
Jazz is not dead. It just smells funny...
