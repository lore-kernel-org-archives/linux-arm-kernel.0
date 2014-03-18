From: pullip.cho@samsung.com (Cho KyongHo)
Date: Tue, 18 Mar 2014 20:09:15 +0900
Subject: [PATCH v11 10/27] iommu/exynos: use managed device helper
 functions
In-Reply-To: <CAK9yfHw7zYaX9EYFE+m3Mh-u8Uiyubx-cS0EwPmfW+0weLiBKw@mail.gmail.com>
References: <20140314140542.f4ded6c50dbd8a1d937bf354@samsung.com>
 <CAK9yfHw7zYaX9EYFE+m3Mh-u8Uiyubx-cS0EwPmfW+0weLiBKw@mail.gmail.com>
Message-ID: <20140318200915.7dd833ce0fddbbd6ecd8dac9@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Mar 2014 20:52:43 +0530, Sachin Kamat wrote:
> Hi KyongHo,
> 
> On 14 March 2014 10:35, Cho KyongHo <pullip.cho@samsung.com> wrote:
> > This patch uses managed device helper functions in the probe().
> >
> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> > ---
> [snip]
> 
> > +       data->clk = devm_clk_get(dev, "sysmmu");
> > +       if (IS_ERR(data->clk)) {
> > +               dev_info(dev, "No gate clock found!\n");
> > +               data->clk = NULL;
> > +       }
> 
> Why aren't you returning from here upon error?

It is for the case of a System MMU which does not need clock gating.

> > +
> > +       ret = clk_prepare(data->clk);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to prepare clk\n");
> > +               return ret;
> >         }
> >
> >         data->sysmmu = dev;
> > @@ -556,17 +553,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
> >
> >         pm_runtime_enable(dev);
> >
> > -       dev_dbg(dev, "Initialized\n");
> > +       dev_dbg(dev, "Probed and initialized\n");
> 
> This message looks redundant.

Ok.

Do you mean that checking sysfs does the same?

Thank you.

KyongHo.
