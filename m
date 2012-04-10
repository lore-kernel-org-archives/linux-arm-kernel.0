From: cjb@laptop.org (Chris Ball)
Date: Tue, 10 Apr 2012 10:12:36 -0400
Subject: [PATCH 1/3] ARM i.MX27: Add devicetree support
In-Reply-To: <20120410091715.GA3852@pengutronix.de> (Sascha Hauer's message of
 "Tue, 10 Apr 2012 11:17:15 +0200")
References: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
 <1330503654-2197-2-git-send-email-s.hauer@pengutronix.de>
 <87lim5zne5.fsf@laptop.org> <20120410091715.GA3852@pengutronix.de>
Message-ID: <87iph7wu97.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 10 2012, Sascha Hauer wrote:
> On Sun, Apr 08, 2012 at 09:48:02PM -0400, Chris Ball wrote:
>> >
>> > [...]
>> > +static int __init imx27_avic_add_irq_domain(struct device_node *np,
>> > +				struct device_node *interrupt_parent)
>> > +{
>> > +	irq_domain_add_simple(np, 0);
>> > +	return 0;
>> > +}
>> > +
>> > +static int __init imx27_gpio_add_irq_domain(struct device_node *np,
>> > +				struct device_node *interrupt_parent)
>> > +{
>> > +	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
>> > +
>> > +	irq_domain_add_simple(np, gpio_irq_base);
>> > +
>> > +	return 0;
>> > +}
>> 
>> This patch was merged for 3.4-rc1, but it fails to compile because Grant
>> removed irq_domain_add_simple() in 3.4-rc1.
>
> Thanks for noting. I assume that irq_domain_add_legacy is the right
> approach here, just like the other i.MX boards do, right?

Yeah, if you look at Grant's removal patch:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6b783f7c5dde2648fa0bbe7fc8ac80d78699e67f

.. he converted all of the in-tree uses to irq_domain_add_legacy()
at the time of removal, so that looks right.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
