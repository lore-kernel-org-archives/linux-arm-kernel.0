From: cavokz@gmail.com (Domenico Andreoli)
Date: Sun, 15 Sep 2013 20:52:21 +0200
Subject: [PATCH v4 4/4] ARM: bcm4760: Add restart hook
In-Reply-To: <201309152009.26462.arnd@arndb.de>
References: <20130914152032.401907974@gmail.com>
 <20130914152124.317379835@gmail.com>
 <201309152009.26462.arnd@arndb.de>
Message-ID: <20130915185220.GA32054@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 15, 2013 at 08:09:26PM +0200, Arnd Bergmann wrote:
> On Saturday 14 September 2013, Domenico Andreoli wrote:
> > +
> > +static int __init bcm4760_wdt_init(void)
> > +{
> > +	struct device_node *node;
> > +
> > +	node = of_find_matching_node(NULL, bcm4760_pm_wdt_match);
> > +	if (!node) {
> > +		pr_info("No bcm4760 watchdog node\n");
> > +		return -1;
> > +	}
> > +
> > +	wdt_regs = of_iomap(node, 0);
> > +	of_node_put(node);
> 
> Since this is now in the drivers directory and initialized at regular
> module_init level, I'd ask you to register it as a proper platform_driver
> and move the initialization into the probe() callback. You also need to
> put Wim as the watchdog subsystem maintainer on Cc (I did in this reply)
> and ask him to merge the driver.
> 
> I assume that Wim will ask you to add a watchdog_register_device() call
> and a set of watchdog_ops to make this a functional driver. From the
> platform perspective, I don't care, but it is certainly a logical step.

issue here is that there is already a proper watchdog driver, the sp805.

so I guess now the task shifts to adding restart hook support to it, right?

Kind regards,
Domenico
