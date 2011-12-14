From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 14 Dec 2011 09:08:20 -0700
Subject: [PATCH 2/9] irq: check domain hwirq range for DT translate
In-Reply-To: <1323876538-20406-3-git-send-email-robherring2@gmail.com>
References: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
 <1323876538-20406-3-git-send-email-robherring2@gmail.com>
Message-ID: <CACxGe6t6mtPt9LsQ77N06n5gWAAUcswhGNut9O==Drq5CJDMpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 8:28 AM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> A DT node may have more than 1 domain associated with it, so make sure
> the hwirq number is within range when doing DT translation.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> ?kernel/irq/irqdomain.c | ? ?3 +++
> ?1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 200ce83..ae6441e 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -135,6 +135,9 @@ int irq_domain_simple_dt_translate(struct irq_domain *d,
> ? ? ? ? ? ? ? ?return -EINVAL;
> ? ? ? ?if (intsize < 1)
> ? ? ? ? ? ? ? ?return -EINVAL;
> + ? ? ? if ((intspec[0] < d->hwirq_base) ||
> + ? ? ? ? ? (intspec[0] >= d->hwirq_base + d->nr_irq))
> + ? ? ? ? ? ? ? return -EINVAL;
>
> ? ? ? ?*out_hwirq = intspec[0];
> ? ? ? ?*out_type = IRQ_TYPE_NONE;
> --
> 1.7.5.4
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
