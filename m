From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 17 Jun 2016 08:24:23 +0200
Subject: [PATCH 1/3] PM / Runtime: Add notifiers for device runtime PM
 events
In-Reply-To: <CAJZ5v0g_7Xsmo0U4YU+V3xjEPfCL7R02VgyB524Mu=dwPwt+Ow@mail.gmail.com>
References: <1465381556-2230-1-git-send-email-m.szyprowski@samsung.com>
 <1465381556-2230-2-git-send-email-m.szyprowski@samsung.com>
 <CAJZ5v0g_7Xsmo0U4YU+V3xjEPfCL7R02VgyB524Mu=dwPwt+Ow@mail.gmail.com>
Message-ID: <8bc9aa9f-f42c-3c1b-b949-c2caf2f2a270@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,


On 2016-06-08 19:18, Rafael J. Wysocki wrote:
> On Wed, Jun 8, 2016 at 12:25 PM, Marek Szyprowski
> <m.szyprowski@samsung.com>  wrote:
>> From: Krzysztof Kozlowski<k.kozlowski@samsung.com>
>>
>> Allow drivers registering for certain runtime PM events of other
>> devices. Some drivers in power domain are more or less coupled. When one
>> driver is suspending (thus leading to power domain being also turned
>> off) the other might have to perform some necessary steps. For example
>> Exynos IOMMU has to save its context.
>>
>> Based on previous work of Sylwester Nawrocki<s.nawrocki@samsung.com>.
>>
>> Signed-off-by: Krzysztof Kozlowski<k.kozlowski@samsung.com>
>> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> No, this is not the right way to address this and using notifiers for
> that is just wrong (because of the potential ordering issues).
>
> Also, the problem is not limited to runtime PM, but also to system
> suspend/resume and initialization/shutdown.
>
> I posted a series of device dependencies patches a few months ago that
> might help to address this problem, but there was almost no interest
> in it at that time.

I spent some time digging for your patches. Sadly no list archives had
them all and I finally found them only in the linux-pm patchwork. This
may explain why there was almost no interest in them.

After some debugging I've managed to get it working for my case. I will
include your patches in my v2 patchset together with the fixes needed to
get it working.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
