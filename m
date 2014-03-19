From: pullip.cho@samsung.com (Cho KyongHo)
Date: Wed, 19 Mar 2014 18:06:28 +0900
Subject: [PATCH v11 13/27] iommu/exynos: support for device tree
In-Reply-To: <53286557.6070808@samsung.com>
References: <20140314140935.e0652b58ce16591b54d0e10b@samsung.com>
 <53230695.9080606@samsung.com>
 <20140318195210.14c953a70498f634032f35b7@samsung.com>
 <53286557.6070808@samsung.com>
Message-ID: <20140319180628.5eecd7347c24f1e697aaaa6a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Mar 2014 16:25:11 +0100, Tomasz Figa wrote:
> On 18.03.2014 11:52, Cho KyongHo wrote:
> > On Fri, 14 Mar 2014 14:39:33 +0100, Tomasz Figa wrote:
> >>> @@ -557,11 +558,23 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
> >>>    	return 0;
> >>>    }
> >>>
> >>> -static struct platform_driver exynos_sysmmu_driver = {
> >>> -	.probe		= exynos_sysmmu_probe,
> >>> -	.driver		= {
> >>> +#ifdef CONFIG_OF
> >>> +static struct of_device_id sysmmu_of_match[] __initconst = {
> >>> +	{ .compatible	= "samsung,sysmmu-v1", },
> >>> +	{ .compatible	= "samsung,sysmmu-v2", },
> >>> +	{ .compatible	= "samsung,sysmmu-v3.1", },
> >>> +	{ .compatible	= "samsung,sysmmu-v3.2", },
> >>> +	{ .compatible	= "samsung,sysmmu-v3.3", },
> >>
> >> Do you need all these compatible strings? I mean, are there any
> >> implementation differences that can't be identified by reading IP
> >> registers, such as REG_MMU_VERSION?
> >>
> >
> > Unfortunately, there is a SoC which overrides REG_MMU_VERSION with
> > a value for RTL designers and it is not related to System MMU
> > versions.
> 
> OK.
> 
> What about having a generic compatible string for Samsung SysMMU then, 
> but an additional property that can override the version to account for 
> such brokenness? If not provided, the version would be read from 
> REG_MMU_VERSION.
> 

Yes it is one of possible idea.
Let me think what better way is.

Thank you.

KyongHo
