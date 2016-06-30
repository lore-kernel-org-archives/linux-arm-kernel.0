From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 30 Jun 2016 17:08:16 +0800
Subject: [PATCH 17/21] usb: chipidea: msm: Make platform data driver
 local instead of global
In-Reply-To: <146722783258.16253.8246581455698560411@sboyd-linaro>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-18-stephen.boyd@linaro.org>
 <20160629112925.GN25236@shlinux2>
 <146722783258.16253.8246581455698560411@sboyd-linaro>
Message-ID: <20160630090816.GB18426@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 12:17:12PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-06-29 04:29:25)
> > On Sun, Jun 26, 2016 at 12:28:34AM -0700, Stephen Boyd wrote:
> > > @@ -204,7 +201,7 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
> > >       of_node_put(ulpi_node);
> > >  
> > >       plat_ci = ci_hdrc_add_device(&pdev->dev, pdev->resource,
> > > -                                  pdev->num_resources, &ci_hdrc_msm_platdata);
> > > +                                  pdev->num_resources, &ci->pdata);
> > >       if (IS_ERR(plat_ci)) {
> > >               dev_err(&pdev->dev, "ci_hdrc_add_device failed!\n");
> > >               ret = PTR_ERR(plat_ci);
> > 
> > You can do something like ci_hdrc_usb2.c, it looks simpler. 
> > 
> 
> Do what exactly? I'd rather not do a structure copy because that wastes
> some memory for a structure that is just a template. We add some more
> code here to assign values directly, but that is smaller size wise than
> the large platdata structure that only has a few values set in it.

But you add one struct ci_hdrc_platform_data pdata entry at struct
ci_hdrc_msm which needs to allocate the memory too. Anyway, it is not a 
big problem.

Acked-by: Peter Chen <peter.chen@nxp.com>

-- 

Best Regards,
Peter Chen
