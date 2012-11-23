From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Nov 2012 18:28:32 +0530
Subject: [PATCH 1/1] gpio: Provide the STMPE GPIO driver with its own IRQ
 Domain
In-Reply-To: <1353674665-31905-1-git-send-email-lee.jones@linaro.org>
References: <1353674665-31905-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CAKohponCWA62+C31nm8QoA5cANPQ09BsU4Sd-x07kA8G_g+AvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 November 2012 18:14, Lee Jones <lee.jones@linaro.org> wrote:
> The STMPE GPIO driver can be used as an IRQ controller by some
> related devices. Here we provide it with its very own IRQ Domain
> so that IRQs can be issued dynamically. This will stand the
> driver in good stead when it is enabled for Device Tree, as this
> it a prerequisite.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c

> +const struct irq_domain_ops stmpe_gpio_irq_simple_ops = {

static?

> +       .unmap = stmpe_gpio_irq_unmap,
> +       .map = stmpe_gpio_irq_map,
> +       .xlate = irq_domain_xlate_twocell,
> +};


Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
