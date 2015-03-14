From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sat, 14 Mar 2015 14:17:50 +0100
Subject: [GIT PULL 2/2] Samsung fixes-2 for v4.0
In-Reply-To: <027501d057f1$f13a5090$d3aef1b0$@kernel.org>
References: <54F4B33E.3070803@kernel.org> <2064108.qlOP0oDx90@wuerfel>
 <20154650.hb5Lekq8n0@wuerfel>
 <CABxcv=nTi_+qkNhw=4NypNnR795cX4QUsWLOR4S+2w3suXvz5g@mail.gmail.com>
 <027501d057f1$f13a5090$d3aef1b0$@kernel.org>
Message-ID: <CABxcv=kDOavviyRC-wPBwqd81J=TYD3bKbaa0dpD-6M0tr01XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On Fri, Mar 6, 2015 at 10:43 AM, Kukjin Kim <kgene@kernel.org> wrote:
>>
>> Yes, the problem is the Exynos DRM driver which has a lot of issues.
>> It's broken if CONFIG_DRM_EXYNOS_IOMMU is enabled which defaults to
>> yes after commit 8dcc14f82f06 ("drm/exynos: IOMMU support should not
>> be selectable by user").
>>
>> I posted a patch to disable IOMMU support on Exynos to avoid these
>> boot failures and also mentioned to Kukjin that it should be a fix for
>> 4.0 [0]. But even with IOMMU disabled, the Exynos DRM is broken in
>> some boards [1] so we may have to disable that driver until everything
>> gets sorted out and is stable again.
>>
> Yes, the fix is in my tree and it will be sent to upstream via arm-soc soon.
>

Sorry for pestering you but I see that the patch to disable
EXYNOS_IOMMU is still not in Linus' master and we are almost in
4.0-rc4 now.

A patch to the Exynos DRM driver to check for IOMMU and fail
gracefully has landed in 4.0-rc so now at least the machines boot but
with IOMMU enabled display is broken in the Exynos5 boards.

> Thanks,
> Kukjin

Best regards,
Javier
