From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Mar 2012 09:08:30 -0800
Subject: [PATCH 2/4] mmc: omap_hsmmc: Use gpio_find_by_chip_name() for
 omap_hsmmc_gpio_init()
In-Reply-To: <4F5075EE.1050902@ti.com>
References: <20120301185044.29210.44521.stgit@kaulin.local>
 <20120301185528.29210.85854.stgit@kaulin.local>
 <4F5075EE.1050902@ti.com>
Message-ID: <20120302170830.GH18901@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120301 22:54]:
> On Friday 02 March 2012 12:25 AM, Tony Lindgren wrote:
> >+		if (slot->gpiochip_cd) {
> >+			pr_warning("MMC %s card detect GPIO chip %s unavailable\n",
> >+				slot->name, slot->gpiochip_cd);
> >+			ret = -ENODEV;
> >+			goto err_free_sp;
> 
> This should just return -ENODEV, nothing really to free here.

Thanks, will correct.
 
> >@@ -2093,8 +2123,7 @@ err1:
> >  	platform_set_drvdata(pdev, NULL);
> >  	mmc_free_host(mmc);
> >  err_alloc:
> >-	omap_hsmmc_gpio_free(pdata);
> >-err:
> >+	omap_hsmmc_gpio_free(host);
> 
> This error handling needs to be fixed up. In case
> omap_hsmmc_gpio_init() fails, which already frees up
> any requested gpios, omap_hsmmc_gpio_free() again tries
> freeing gpios.

Hmm that sounds like a separate patch that should be a fixed
before this series?

Regards,

Tony
