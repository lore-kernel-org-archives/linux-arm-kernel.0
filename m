From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 26 Jan 2015 13:06:07 +0100
Subject: [PATCH v5 11/18] iommu: exynos: remove useless device_add/remove
 callbacks
In-Reply-To: <20150126110059.GC30345@8bytes.org>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
 <1422028288-891-12-git-send-email-m.szyprowski@samsung.com>
 <2829552.kzfCU5HyxQ@avalon> <20150126110059.GC30345@8bytes.org>
Message-ID: <54C62DAF.6020809@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-01-26 12:00, Joerg Roedel wrote:
> Hi Laurent,
>
> On Sun, Jan 25, 2015 at 05:38:22PM +0200, Laurent Pinchart wrote:
>> IOMMU groups still seem a bit unclear to me. Will Deacon has nicely explained
>> what they represent in
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310816.html.
>> The IOMMU core doesn't make groups
>> mandatory, but requires them in some code paths.
>>
>> For example the coldplug device add function add_iommu_group() called for all
>> devices already registered when bus_set_iommu() is called will try to warn of
>> devices added multiple times with a WARN_ON(dev->iommu_group). Another example
>> is the iommu_bus_notifier() function which will call the remove_device()
>> operation only when dev->iommu_group isn't NULL.
>>
>> I'm thus unsure whether groups should be made mandatory, or whether the IOMMU
>> core should be fixed to make them really optional (or, third option, whether
>> there's something I haven't understood properly).
> My plan is to make IOMMU groups mandatory. I am currently preparing and
> RFC patch-set to introduce default-domains (which will be per group). So
> when all IOMMU drivers are converted to make use of default domains the
> iommu groups will be mandatory.

Thanks for the comment, I will implement all that will be needed for it 
to exynos
iommu driver, but I would like to ask if you plan to merge my existing 
patches for
exynos iommu driver to your tree?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
