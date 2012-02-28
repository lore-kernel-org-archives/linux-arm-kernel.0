From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Feb 2012 17:22:59 -0800
Subject: [PATCH v2 0/6] gpio/omap: Cleanup and adaptation to Device Tree
In-Reply-To: <1330122091-28113-1-git-send-email-b-cousson@ti.com> (Benoit
 Cousson's message of "Fri, 24 Feb 2012 23:21:25 +0100")
References: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Message-ID: <87linnrbt8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> Hi Grant,
>
> Here are a couple of GPIO cleanup + the DT adaptation patches.
> This update (compared to v1 [1]) is adding an extra fix for SPARSE_IRQ support
> and add the second cell in the binding for GPIO IRQ type that was missing
> previously whereas the driver does support it.

For the OMAP GPIO changes,

Reviewed-by: Kevin Hilman <khilman@ti.com>

However, I had some problems trying to merge this to test it.

I'm also curious how/who we should merge this.  Since it depends on
stuff that Grant is queueing (or has queued), I suppose it should go
through his tree.

> This series is based on 3.3-rc4 + for_3.4/dt_base branch to get
> the needed cleanup and fixes for OMAP.
>
> The interrupt controller support is using irq_domain_add_legacy for
> the moment and will be updated next to use irqchip irq_domain.

It appears your current dt_gpio branch is based on some older version of
your dt_irq_domain branch than the one you just submitted for a pull request.

> It requires the irq_domain generalization and refinement series
> available at:
>   git://git.secretlab.ca/git/linux-2.6 irqdomain/next
>   
> It requires as well Tarun's GPIO cleanup series available at:
>   git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_cleanup_fixes_v9

Rather than Tarun's branch, can you use Grant's GPIO branch, which has
the final version he pulled from my for_3.4/gpio/runtime-pm-cleanup
branch.  Tarun's branch causes some merge conflicts with what Grant has
already merged.

Kevin

> This series is available here for reference:
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_gpio
