From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 8 Feb 2017 14:57:42 +0100
Subject: [PATCH 09/10] iommu/exynos: Make use of iommu_device_register
 interface
In-Reply-To: <3e4709a7-2231-7c76-18bd-6e2d6b802b8e@samsung.com>
References: <1486397429-29327-1-git-send-email-joro@8bytes.org>
 <CGME20170206161330epcas3p185c7719afc89ab2ad87e55e9f62ccfa1@epcas3p1.samsung.com>
 <1486397429-29327-10-git-send-email-joro@8bytes.org>
 <3e4709a7-2231-7c76-18bd-6e2d6b802b8e@samsung.com>
Message-ID: <20170208135742.GE7339@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Feb 07, 2017 at 01:36:15PM +0100, Marek Szyprowski wrote:
> >+	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
> >+				     "sysmmu.%pa", &ioaddr);
> 
> Can we stick to the common name across the /sysfs and use
> dev_name(data->sysmmu)
> or even dev_name(dev) here?
> 
> ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
> dev_name(dev));

That means that we have multiple 'struct device' with the same name,
no? I think will lead to confusion when using dev_printk, as its not
clear anymore which device is refered to in the message.


	Joerg
