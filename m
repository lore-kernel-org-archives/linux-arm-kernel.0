From: weiyj_lk@163.com (Wei Yongjun)
Date: Thu, 7 Jul 2016 10:50:35 +0800
Subject: [PATCH -next] iommu/exynos: Fix return value check in
 exynos_iommu_of_setup()
In-Reply-To: <20160707023443.GF23620@samsunx.samsung>
References: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
 <CGME20160706131005epcas1p2f8c6a70cbacbcdeb3e5293f37b0140ce@epcas1p2.samsung.com>
 <577D0316.1050502@samsung.com> <20160707023443.GF23620@samsunx.samsung>
Message-ID: <6454b35e-790a-b603-92f4-66539839b6ad@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> just a question,
>
>>>  	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
>>> -	if (IS_ERR(pdev))
>>> -		return PTR_ERR(pdev);
>>> +	if (!pdev)
>>> +		return -ENOMEM;
>>>  
>>>  	/*
>>>  	 * use the first registered sysmmu device for performing
>>>
> is ENOMEM the right return value? of_platform_device_create()
> doesn't fail only in case of malloc failure.
>
> Shouldn't it be ENODEV instead, which might also mean with some
> imagination that there is no memory available for that device?
>
Your are right, I will change the error to -ENODEV and resend the patch.

Thanks,
Wei Yongjun
