From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Jul 2017 08:20:06 +0200
Subject: [PATCH] irqchip: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-30-robh@kernel.org>
References: <20170718214339.7774-30-robh@kernel.org>
Message-ID: <20170719062006.hivodv3zppq6swdo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:43:10PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-tegra at vger.kernel.org
> ---
>  drivers/irqchip/irq-bcm2835.c            |  9 ++++-----
>  drivers/irqchip/irq-bcm2836.c            |  5 ++---
>  drivers/irqchip/irq-crossbar.c           |  6 +++---
>  drivers/irqchip/irq-digicolor.c          |  8 ++++----
>  drivers/irqchip/irq-dw-apb-ictl.c        | 12 ++++++------
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c |  2 +-
>  drivers/irqchip/irq-gic-v3-its.c         |  6 +++---
>  drivers/irqchip/irq-gic-v3.c             | 11 ++++-------
>  drivers/irqchip/irq-imx-gpcv2.c          |  4 ++--
>  drivers/irqchip/irq-lpc32xx.c            |  2 +-
>  drivers/irqchip/irq-mtk-sysirq.c         |  3 +--
>  drivers/irqchip/irq-mxs.c                |  4 ++--
>  drivers/irqchip/irq-stm32-exti.c         |  8 ++++----
>  drivers/irqchip/irq-sun4i.c              |  6 +++---

for sun4i:
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170719/bec97007/attachment.sig>
