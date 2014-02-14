From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 14 Feb 2014 15:28:38 +0000
Subject: [PATCH 1/2] mfd: twl4030-madc: Add devicetree support.
In-Reply-To: <CAAfyv36FH364OPnktx_Qh6sUfwYe7hynqrc3Xs_tY4gPXqQWvA@mail.gmail.com>
References: <1392383861-14169-1-git-send-email-marek@goldelico.com>
 <20140214134815.GD13293@lee--X1>
 <CAAfyv36FH364OPnktx_Qh6sUfwYe7hynqrc3Xs_tY4gPXqQWvA@mail.gmail.com>
Message-ID: <20140214152838.GA30687@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> Signed-off-by: Marek Belisko <marek@goldelico.com>
> >> ---
> >>  .../devicetree/bindings/mfd/twl4030-madc.txt       | 18 +++++++++++++
> >>  drivers/mfd/twl4030-madc.c                         | 31
> >> ++++++++++++++++++++--
> >
<snip>

> >> +static struct twl4030_madc_platform_data *
> >> +     twl4030_madc_of_parse(struct platform_device *pdev)
> >> +{
> >> +     struct twl4030_madc_platform_data *pdata;
> >> +
> >> +     pdata = devm_kzalloc(&pdev->dev,
> >> +                     sizeof(struct twl4030_madc_platform_data), GFP_KERNEL);
> >
> > s/struct twl4030_madc_platform_data/*pdata/
> Right typo.

Sorry, my comment of ambiguous.

I mean do this:

  sizeof(*pdata)

... instead of this:

  sizeof(struct twl4030_madc_platform_data)

> >> +     if (!pdata)
> >> +             return ERR_PTR(-ENOMEM);
> >> +
> >> +     pdata->irq_line = platform_get_irq(pdev, 0);
> >
> > Why weren't 'resources' used in the original implementation?
> Not sure I'm not an author :). It's passed in platform data.

Yes, I saw that. It should be changed.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
