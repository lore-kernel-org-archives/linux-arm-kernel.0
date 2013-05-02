From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 2 May 2013 13:35:10 -0600
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <5182B902.7040908@gmail.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130502185322.GA29333@obsidianresearch.com>
 <5182B902.7040908@gmail.com>
Message-ID: <20130502193510.GA29522@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 09:05:38PM +0200, Sebastian Hesselbarth wrote:

> >>+static struct of_device_id orion_irq_dt_ids[] __initconst = {
> >>+	{ .compatible = "marvell,orion-mpic", .data = orion_of_init },
> >>+	{ }
> >
> >Is there a strong reason to change the compatible string? Looks to me
> >like either the new driver or the old driver will bind depending on
> >what is in the machine description. No need for a new string?
> 
> The reason for a new compatible string is, that we will also need an
> secondary irq controller for bridge irqs. That could be called
> marvell,orion-spic. Dove is again a little bit different than the
> others and this will require timer and especially rtc not to share
> bridge irqs here. RTC irq is located in PMU regs on Dove instead of
> bridge regs.

As Arnd mentioned, I would keep the old name then..

The bridge controller can be called marvell,orion-intc-bridge, and if
Dove needs a pmu controller, marvell,dove-intc-pmu ?

> >.. which lets this go away, use the generic irqchip_init instead of
> >orion_init_irq.
> 
> Same as above.

I have kirkwood HW but I haven't had time to make newer kernels run on
it, otherwise I'd test it too :(

Jason
