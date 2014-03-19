From: pullip.cho@samsung.com (Cho KyongHo)
Date: Wed, 19 Mar 2014 18:07:57 +0900
Subject: [PATCH v11 19/27] iommu/exynos: add support for power management
 subsystems.
In-Reply-To: <53286730.1060807@samsung.com>
References: <20140314141028.4b0b62d895905988ab5dda88@samsung.com>
 <53232959.7020306@samsung.com>
 <20140318202320.a3101304bbc51cc9f169cdaa@samsung.com>
 <53286730.1060807@samsung.com>
Message-ID: <20140319180757.a1552386b81e698914d4bcc6@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Mar 2014 16:33:04 +0100, Tomasz Figa wrote:
> On 18.03.2014 12:23, Cho KyongHo wrote:
> > On Fri, 14 Mar 2014 17:07:53 +0100, Tomasz Figa wrote:
> >> Hi KyongHo,
> >>
> >> On 14.03.2014 06:10, Cho KyongHo wrote:
> 
> [snip]
> 
> >>> @@ -677,11 +679,40 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
> >>>    	platform_set_drvdata(pdev, data);
> >>>
> >>>    	pm_runtime_enable(dev);
> >>> +	data->runtime_active = !pm_runtime_enabled(dev);
> >>
> >> Hmm, this seems to be a bit misleading. The field is named
> >> runtime_active, but the assignment makes it true if PM runtime is _not_
> >> enabled (i.e. inactive). Is this correct?
> >>
> >
> > I agree that it may lead misunderstood.
> > data->runtime_active actually indicates if electric power is asserted
> > to the System MMU. pm_runtime_enable() call must enable runtime pm
> > for the given device. If runtime pm is not enabled although pm_runtime_enable()
> > is called, CONFIG_PM_RUNTIME is not configured.
> >
> > Actually, it is replacible with
> > if (IS_ENABLED(CONFIG_PM_RUNTIME))
> >      data->runtime_active = true;
> 
> I would keep it as !pm_runtime_enabled(dev), but rename the field to 
> something more meaningful, like data->is_powered_on.
> 

That is good idea.

thanks for advice.

KyongHo.
