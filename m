From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Mar 2012 10:35:05 -0800
Subject: [PATCH 2/4] mmc: omap_hsmmc: Use gpio_find_by_chip_name() for
 omap_hsmmc_gpio_init()
In-Reply-To: <20120302170830.GH18901@atomide.com>
References: <20120301185044.29210.44521.stgit@kaulin.local>
 <20120301185528.29210.85854.stgit@kaulin.local>
 <4F5075EE.1050902@ti.com> <20120302170830.GH18901@atomide.com>
Message-ID: <20120302183505.GN18901@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120302 08:38]:
> * Rajendra Nayak <rnayak@ti.com> [120301 22:54]:
>
> > >@@ -2093,8 +2123,7 @@ err1:
> > >  	platform_set_drvdata(pdev, NULL);
> > >  	mmc_free_host(mmc);
> > >  err_alloc:
> > >-	omap_hsmmc_gpio_free(pdata);
> > >-err:
> > >+	omap_hsmmc_gpio_free(host);
> > 
> > This error handling needs to be fixed up. In case
> > omap_hsmmc_gpio_init() fails, which already frees up
> > any requested gpios, omap_hsmmc_gpio_free() again tries
> > freeing gpios.
> 
> Hmm that sounds like a separate patch that should be a fixed
> before this series?

Nope, I was confused. The error handling needs to change
as the omap_hsmmc_gpio_init() got moved later so host is
initialized. Will fix.

Regards,

Tony
