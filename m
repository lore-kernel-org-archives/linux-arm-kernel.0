From: cjb@laptop.org (Chris Ball)
Date: Sun, 08 Apr 2012 21:43:44 -0400
Subject: [PATCH v2 5/7] ARM: mmp: append OF support on pxa168
In-Reply-To: <1330950111-30797-6-git-send-email-haojian.zhuang@marvell.com>
 (Haojian Zhuang's message of "Mon, 5 Mar 2012 20:21:49 +0800")
References: <1330950111-30797-1-git-send-email-haojian.zhuang@marvell.com>
 <1330950111-30797-6-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <87ty0tznlb.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 05 2012, Haojian Zhuang wrote:
> +static int __init mmp_intc_add_irq_domain(struct device_node *np,
> +					   struct device_node *parent)
> +{
> +	irq_domain_add_simple(np, 0);
> +	return 0;
> +}
> +
> +static int __init mmp_gpio_add_irq_domain(struct device_node *np,
> +					   struct device_node *parent)
> +{
> +	irq_domain_add_simple(np, IRQ_GPIO_START);
> +	return 0;
> +}

This patch was merged for 3.4-rc1, but it fails to compile because Grant
removed irq_domain_add_simple() in 3.4-rc1.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
