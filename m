From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 29 Jun 2016 18:26:33 -0700
Subject: [PATCH 19/21] usb: chipidea: msm: Be silent on probe defer errors
In-Reply-To: <20160630010628.GA19211@shlinux2>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-20-stephen.boyd@linaro.org>
 <20160630010628.GA19211@shlinux2>
Message-ID: <146724999394.32568.4689806398334141027@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-06-29 18:06:28)
> On Sun, Jun 26, 2016 at 12:28:36AM -0700, Stephen Boyd wrote:
> > ---
> >  drivers/usb/chipidea/ci_hdrc_msm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> > index 7d191928e55b..2ed9a181f4b6 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> > @@ -241,7 +241,8 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
> >       plat_ci = ci_hdrc_add_device(&pdev->dev, pdev->resource,
> >                                    pdev->num_resources, &ci->pdata);
> >       if (IS_ERR(plat_ci)) {
> > -             dev_err(&pdev->dev, "ci_hdrc_add_device failed!\n");
> > +             if (PTR_ERR(plat_ci) != -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "ci_hdrc_add_device failed!\n");
> >               ret = PTR_ERR(plat_ci);
> >               goto err_mux;
> >       }
> 
> Why not let ret equals to PTR_ERR(plat_ci) first, and using ret to
> compare?

Sure. I've fixed it up.
