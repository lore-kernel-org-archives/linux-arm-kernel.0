From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Oct 2012 12:27:32 -0600
Subject: [PATCH 2/3] irqchip: Move ARM VIC to drivers/irqchip
In-Reply-To: <1351608860-24617-3-git-send-email-robherring2@gmail.com>
References: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
 <1351608860-24617-3-git-send-email-robherring2@gmail.com>
Message-ID: <50901C14.5050605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2012 08:54 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that we have drivers/irqchip, move VIC irqchip to drivers/irqchip.

> diff --git a/arch/arm/common/vic.c b/drivers/irqchip/irq-vic.c
> similarity index 100%
> rename from arch/arm/common/vic.c
> rename to drivers/irqchip/irq-vic.c

"gic" and "vic" seems a little generic for filenames and symbol names;
what about irq-arm-vic.c and irq-arm-gic.c? Similarly...

> diff --git a/drivers/irqchip/irqchip.h b/drivers/irqchip/irqchip.h

>  int gic_of_init(struct device_node *node, struct device_node *parent);
> +int vic_of_init(struct device_node *node, struct device_node *parent);

... perhaps rename those to arm_[gv]ic_of_init()?

Are/will there be multiple versions of the GIC? I guess we can always
introduce a GIC2 later if needed, and leave the current one with an
unversioned name.
