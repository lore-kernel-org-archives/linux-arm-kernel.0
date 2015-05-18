From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 18 May 2015 14:09:14 +0200
Subject: [PATCH v6 10/25] iommu: exynos: remove useless device_add/remove
 callbacks
In-Reply-To: <20150505145538.GL15736@8bytes.org>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-11-git-send-email-m.szyprowski@samsung.com>
 <20150505145538.GL15736@8bytes.org>
Message-ID: <5559D66A.5070406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-05-05 16:55, Joerg Roedel wrote:
> On Mon, May 04, 2015 at 10:16:05AM +0200, Marek Szyprowski wrote:
>> The driver doesn't need to do anything important in device add/remove
>> callbacks, because initialization will be done from device-tree specific
>> callbacks added later. IOMMU groups created by current code were never
>> used.
> Hmm, will this remove support for iommu-groups in the exynos driver? I
> am still working on the default-domain patch-set which makes iommu-group
> support mandatory for iommu-drivers.

I you wish, I can leave this code. iommu-groups were not used at all on 
Exynos,
so I thought that there is no point keeping useless code.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
