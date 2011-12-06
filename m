From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 6 Dec 2011 07:34:16 +0100
Subject: [PATCH v3 1/3] ARM: at91/aic: add irq domain and device tree
 support
In-Reply-To: <1322754127-15206-1-git-send-email-nicolas.ferre@atmel.com>
References: <1322590066-430-1-git-send-email-nicolas.ferre@atmel.com>
 <1322754127-15206-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20111206063416.GI9192@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:42 Thu 01 Dec     , Nicolas Ferre wrote:
> Add an irqdomain for the AIC interrupt controller.
> The device tree support is mapping the registers and
> is using the irq_domain_simple_ops to manage hwirq
> translation.
> The documentation is describing the meaning of the
> two cells required for using this "interrupt-controller"
> in a device tree node.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> This patch should go on top of Jamie's patch:
> "irqdomain: export irq_domain_simple_ops for !CONFIG_OF"
> https://lkml.org/lkml/2011/12/1/109
> 
> v3: - change number of cells to define an AIC interrupt (irq trigger type)
>     - change current .dtsi files to match specification
>     - use irq_domain_simple_ops (for DT mapping)
> 
> v2: - use of_irq_init() function for device tree probing
>     - add documentation
>     - use own simple struct irq_domain_ops
just one stuff missing the definition of the external irq

Best Regards,
J.
