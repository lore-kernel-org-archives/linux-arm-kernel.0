From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Jan 2017 10:10:59 -0800
Subject: 4.10-rc1 on Nokia N900: regression, WARN_ON() omap_l3_smx.c
In-Reply-To: <20161229231411.GA6865@amd>
References: <20161229231411.GA6865@amd>
Message-ID: <20170102181058.GF9325@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [161229 15:14]:
> Hi!
> 
> I forgot I had v4.10-rc1 running, and now I got warning on all the
> consoles (hand-copied).
> 
> 
> Unhandled fault: external abort on non-linefetch (0x1028) at
> 0xfa0ab060
> ...
> Comm: kworker/0:0 Not tainted.
> Workqueue: events musb_irq_work
> ...
> PC is at musb_default_readb().
> ...

This means the clocks are not enabled at that point.

> WARNING: CPU: 0 ... at drivers/bus/omap_l3_smx.c:166
> omap3_l3_app_irq+0xcc/...
> Tainted: GDW.

If you comment out postcore_initcall_sync(omap3_l3_init);
in drivers/bus/omap_l3_smx.c you'll see the proper stack
trace instead of the l3 interrupt trace. The system will
hang at that point most likely.

> I do have patches to allow nfsroot over usb. But they worked ok in
> v4.9... Does anyone see it, too?

Hmm not much has changed since v4.9. Are you sure you
had v4.9 or some earlier v4.9-rc version?

Regards,

Tony
