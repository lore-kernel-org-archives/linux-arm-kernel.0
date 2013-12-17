From: arunkk.samsung@gmail.com (Arun Kumar K)
Date: Tue, 17 Dec 2013 13:35:24 +0530
Subject: [PATCH 3/3] cpufreq: exynos: Add exynos5420 cpufreq driver
In-Reply-To: <20131217090005.1e04ff7b@amdc2363>
References: <1386323284-15646-1-git-send-email-arun.kk@samsung.com>
 <1386323284-15646-4-git-send-email-arun.kk@samsung.com>
 <CAKohpo=vkZRSQ5Xk-Tsm9QVy8h2F5Ehpm4Y8JWi5xjx0OD72tw@mail.gmail.com>
 <20131217090005.1e04ff7b@amdc2363>
Message-ID: <CALt3h79iuOnmeCBxHjPN3qAoiuwHYBXAp_eSTDewxc96zqSOOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On Tue, Dec 17, 2013 at 1:30 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Viresh,
>
>> On 6 December 2013 15:18, Arun Kumar K <arun.kk@samsung.com> wrote:
>> > From: "Arjun.K.V" <arjun.kv@samsung.com>
>> >
>> > The patch adds cpufreq driver for exynos5420.
>> >
>> > Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
>> > Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> > Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
>> > ---
>> >  drivers/cpufreq/Kconfig.arm          |   11 ++
>> >  drivers/cpufreq/Makefile             |    1 +
>> >  drivers/cpufreq/exynos-cpufreq.c     |    2 +
>> >  drivers/cpufreq/exynos-cpufreq.h     |    8 +
>> >  drivers/cpufreq/exynos5420-cpufreq.c |  346
>> > ++++++++++++++++++++++++++++++++++ 5 files changed, 368
>> > insertions(+) create mode 100644
>> > drivers/cpufreq/exynos5420-cpufreq.c
>>
>> Hmm.. That's the second big LITTLE SoC after TC2..
>> And we already have a generic enough driver for all big LITTLE
>> platforms: arm_big_little.c
>>
>> Please use that with a glue clk and regulator driver if required. We
>> don't want to get any new driver for big LITTLE unless there is a
>> real limitation.
>>
>> Also, the generic big LITTLE driver supports IKS (In Kernel Switcher)
>> which may or maynot be used by Exynos.
>>
>> @Lukasz: We can't use cpu0 driver here as we have multiple clusters
>> here A7 and A15, and so there are two clock domains instead of one.
>> That's why we have written big LITTLE driver.
>
> When I first looked into the patch - it was almost identical to the
> exynos4210-cpufreq.c or exynos4x12-cpufreq.c files.
>
> Also I didn't spot the code characteristic to IKS. It seems like the
> code in this file is not aware if it runs on A7 or A15.
>

This initial version was only for A15s and I was planning for an incremental
patch for A7s along with common code for the  same. Now that is not needed
with the generic implementation in place.

Regards
Arun
