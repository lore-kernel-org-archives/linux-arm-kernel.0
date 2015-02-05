From: carlo@caione.org (Carlo Caione)
Date: Thu, 5 Feb 2015 11:13:15 +0100
Subject: [PATCH v2 2/2] arm/dma-mapping: Respect NO_KERNEL_MAPPING when we
 don't have an IOMMU
In-Reply-To: <54D1F2AE.4070003@samsung.com>
References: <1423041800-27859-1-git-send-email-carlo@caione.org>
 <1423041800-27859-3-git-send-email-carlo@caione.org>
 <54D1F2AE.4070003@samsung.com>
Message-ID: <CAOQ7t2ZtWA4gnatMgRuk17BPycM8A6MaPD7s6jeprr3VWqOaPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 4, 2015 at 11:21 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hello,
>
> On 2015-02-04 10:23, Carlo Caione wrote:
>>
>> From: "Jasper St. Pierre" <jstpierre@mecheye.net>
>>
>> Even without an iommu, NO_KERNEL_MAPPING is still convenient to save on
>> kernel address space in places where we don't need a kernel mapping.
>> Implement support for it in the two places where we're creating an
>> expensive mapping.
>>
>> __alloc_from_pool uses an internal pool from which we already have
>> virtual addresses, so it's not relevant, and __alloc_simple_buffer uses
>> alloc_pages, which will always return a lowmem page, which is already
>> mapped into kernel space, so we can't prevent a mapping for it in that
>> case.
>>
>> Signed-off-by: Jasper St. Pierre <jstpierre@mecheye.net>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> Reviewed-by: Rob Clark <robdclark@gmail.com>
>> Reviewed-by: Daniel Drake <dsd@endlessm.com>
>
>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks. Who is supposed to take this patch? Russel?

Cheers,

-- 
Carlo Caione
