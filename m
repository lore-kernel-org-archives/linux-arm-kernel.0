From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 6 Jan 2014 16:08:59 +0000
Subject: [PATCH 1/2] ARM: sun7i: Add irqchip driver for NMI controller
In-Reply-To: <1388936345-5009-2-git-send-email-carlo.caione@gmail.com>
References: <1388936345-5009-1-git-send-email-carlo.caione@gmail.com>
 <1388936345-5009-2-git-send-email-carlo.caione@gmail.com>
Message-ID: <20140106160858.GE24664@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 05, 2014 at 03:39:04PM +0000, Carlo Caione wrote:
> Allwinner A20 SoCs have special registers to control / (un)mask /
> acknowledge NMI. This NMI controller is separated and independent from GIC.
> This patch adds a new irqchip to manage NMI.
> 
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
> ---
>  drivers/irqchip/Makefile        |   1 +
>  drivers/irqchip/irq-sun7i-nmi.c | 191 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 192 insertions(+)
>  create mode 100644 drivers/irqchip/irq-sun7i-nmi.c

[...]

> +IRQCHIP_DECLARE(sun7i_sc_nmi, "allwinner,sun7i-sc-nmi", sun7i_sc_nmi_irq_init);

Binding document please.

Thanks,
Mark.
