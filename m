From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Jun 2013 08:21:10 -0700
Subject: [PATCH 3/4] pinctrl: single: omap: Add SoC specific module for
 wake-up events
In-Reply-To: <688FBEF7C8277944BE5AED9A41FB1EBC1AB12D0F@DNCE05.ent.ti.com>
References: <20130607203936.16513.57494.stgit@localhost>
 <20130607205044.16513.27675.stgit@localhost>
 <688FBEF7C8277944BE5AED9A41FB1EBC1AB12D0F@DNCE05.ent.ti.com>
Message-ID: <20130610152109.GI8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Quadros, Roger <rogerq@ti.com> [130610 03:09]:
> +
> +static int __init pcs_omap_init(void)
> +{
> +       platform_driver_register(&pcs_omap_soc_driver);
> +       platform_driver_register(&pcs_omap_driver);
> +
> +       return 0;
> +}
> +module_init(pcs_omap_init);
> 
> It seems this has to be moved to an earlier place (e.g. subsys_initcall)
> else the pinctrl core fails to find the pinctrl device at the device creation
> time and bails out with -EPROBE_DEFER. Also, that device is never
> created again, so -EPROBE_DEFER doesn't seem to work there.

Ah here, found your other comment :)

That's not needed, the real fix is to make twl-core.c and friends to
be regular module_init. There are already patches queued for that.
 
Regards,

Tony
