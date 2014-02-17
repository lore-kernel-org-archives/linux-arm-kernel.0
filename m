From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 17 Feb 2014 14:02:09 +0530
Subject: [PATCH 2/2] ARM: tegra: fix Dalmore PMIC IRQ polarity
In-Reply-To: <1392415108-4365-2-git-send-email-swarren@wwwdotorg.org>
References: <1392415108-4365-1-git-send-email-swarren@wwwdotorg.org>
 <1392415108-4365-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5301C909.1090401@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 February 2014 03:28 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> The Tegra PMC's resume-from-sleep logic wants an active-low IRQ input
> from the PMIC. However, the PMIC IRQ is also routed to the GIC, which
> only supports active high IRQs (or rising edge). Hence, the signal must
> be inverted in the PMC before being routed to the GIC. This implies that
> the PMC DT property nvidia,invert-interrupt must be set, and it is.
>
> The PMIC's DT interrupts property must represent the IRQ level at the
> GIC, since that is the PMIC's parent IRQ controller. Fix the PMIC's
> interrupts property to correctly describe the GIC input polarity.
>
> However, the PMIC IRQ output's polarity is programmable in HW, and by
> default follows the parent IRQ controller's input polarity. We need to
> have an active-low output due to the inversion inside the Tegra PMC.
> Hence, add the ti,irq-externally-inverted property to the PMIC.
>
Looks good to me.

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
