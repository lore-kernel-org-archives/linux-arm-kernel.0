From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 9 Jul 2015 10:24:09 +0200 (CEST)
Subject: [patch] irqchip/sirfsoc: Fix generic chip allocation wreckage
In-Reply-To: <20150706101543.470696950@linutronix.de>
References: <20150706101543.470696950@linutronix.de>
Message-ID: <alpine.DEB.2.11.1507091022350.5134@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jul 2015, Thomas Gleixner wrote:
>  
>  #define SIRFSOC_NUM_IRQS		64
> +#define SIRFSOC_NUM_BANKS		(SIRFSOC_NUM_IRQS / 2)

Heat induced brain damage, that wants to be:

+#define SIRFSOC_NUM_BANKS		(SIRFSOC_NUM_IRQS / 32)
