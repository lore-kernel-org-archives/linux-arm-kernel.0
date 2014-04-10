From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Apr 2014 11:04:59 +0100
Subject: [PATCH 07/27] irqchip: Declare cortex-a7's irqchip to initialize
 gic from dt
In-Reply-To: <1397122124-15690-8-git-send-email-cw00.choi@samsung.com>
 (Chanwoo Choi's message of "Thu, 10 Apr 2014 10:28:24 +0100")
References: <1397122124-15690-1-git-send-email-cw00.choi@samsung.com>
 <1397122124-15690-8-git-send-email-cw00.choi@samsung.com>
Message-ID: <878urd33g4.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10 2014 at 10:28:24 am BST, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch declare coretex-a7's irqchip to initialze gic from dt
> with "arm,cortex-a7-gic" data.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/irqchip/irq-gic.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 4300b66..8e906e4 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1069,6 +1069,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>  }
>  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
>  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
> +IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);

Frankly, this patch adds no value. Are we going to add
"arm,cortex-a12-gic", "arm,cortex-a17-gic", "arm,cortex-a53-gic",
"arm,cortex-a57-gic"? And that's just to mention the ARM Ltd cores...

Instead, how about defining a generic "arm,gic" property, and mandate
that new DT files are using that? We can always use a more precise
compatible for quirks.

Mark, what do you think? I think this has been discussed in the past
already.

	M.
-- 
Jazz is not dead. It just smells funny.
