From: robdclark@gmail.com (Rob Clark)
Date: Wed, 21 Sep 2011 08:40:06 -0500
Subject: [PATCH v4] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
In-Reply-To: <000d01cc785b$cc5cc290$651647b0$%szyprowski@samsung.com>
References: <1315568333-6704-1-git-send-email-inki.dae@samsung.com>
	<4E6B6E5E.3010702@shipmail.org>
	<CAF6AEGt70bk8idsG48tmo_hgWY6M9kSNrEqyyLknYVYn83u4Rw@mail.gmail.com>
	<4E6D278C.6010508@shipmail.org> <4E6DA767.9080408@shipmail.org>
	<000501cc7282$7e7dcb70$7b796250$%dae@samsung.com>
	<CAF6AEGtE9fmbZ-_nV5Lr-x+W5hiGbLfk2GdFNzQgHwJ+hNvn-g@mail.gmail.com>
	<001c01cc72a2$d872c390$89584ab0$%dae@samsung.com>
	<4E705E4D.5030206@shipmail.org>
	<CAF6AEGtgfvbKdjiLpjFxArSVKFeb-GUdmNhN0ra0codPogvbUA@mail.gmail.com>
	<000d01cc785b$cc5cc290$651647b0$%szyprowski@samsung.com>
Message-ID: <CAF6AEGv=_LjEf7A9r2G85uLo-cf1nj2EBx4hvFSbvxfR2FHZHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 7:41 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>> I'm not entirely sure what will happen w/ dma_alloc_coherent, etc, if
>> the global CMA pool is exhausted.
>>
>> Marek? ?I guess you know what would happen?
>
> The allocation will simply fail and dma_alloc_coherent will return NULL.
>

Ok, so we should probably setup device private pools so that userspace
cannot allocate so much buffer memory that dma_alloc_coherent fails
for other devices..

This is what I've done so far for omapdrm driver, although it is part
of the other patch that adds the platform-device..

Thx

BR,
-R
