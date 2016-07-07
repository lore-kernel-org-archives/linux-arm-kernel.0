From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 07 Jul 2016 11:34:43 +0900
Subject: [PATCH -next] iommu/exynos: Fix return value check in
 exynos_iommu_of_setup()
In-Reply-To: <577D0316.1050502@samsung.com>
References: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
 <CGME20160706131005epcas1p2f8c6a70cbacbcdeb3e5293f37b0140ce@epcas1p2.samsung.com>
 <577D0316.1050502@samsung.com>
Message-ID: <20160707023443.GF23620@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

just a question,

> >  	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
> > -	if (IS_ERR(pdev))
> > -		return PTR_ERR(pdev);
> > +	if (!pdev)
> > +		return -ENOMEM;
> >  
> >  	/*
> >  	 * use the first registered sysmmu device for performing
> > 
> 

is ENOMEM the right return value? of_platform_device_create()
doesn't fail only in case of malloc failure.

Shouldn't it be ENODEV instead, which might also mean with some
imagination that there is no memory available for that device?

Thanks,
Andi

> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
