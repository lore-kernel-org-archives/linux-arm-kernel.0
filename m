From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 26 May 2015 17:43:47 +0900
Subject: [PATCH] drm/nouveau/platform: fix compilation if !CONFIG_IOMMU
In-Reply-To: <3919309.jIrkBUJG1x@wuerfel>
References: <555BD66A.5020704@nvidia.com>
 <1432102224-15169-1-git-send-email-acourbot@nvidia.com>
 <3919309.jIrkBUJG1x@wuerfel>
Message-ID: <CAAVeFuLpjPvyGbN7wgiWCo6DTXA2s8-sQheiGjDiqbnZ4Rg3gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 4:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 20 May 2015 15:10:24 Alexandre Courbot wrote:
>> The lack of IOMMU API support can make nouveau_platform_probe_iommu()
>> fail to compile because struct iommu_ops is then empty. Fix this by
>> skipping IOMMU probe in that case - lack of IOMMU on platform devices
>> is sub-optimal, but is not an error.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>> This is an alternative to https://lkml.org/lkml/2015/5/19/484. Most users
>> of Nouveau do not care about IOMMU support, so we should not impose that
>> option on them.
>>
>
> Yes, good idea.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks. Dave, are you ok with this patch? If so, can you take it?
