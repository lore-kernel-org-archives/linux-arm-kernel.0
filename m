From: arunkk.samsung@gmail.com (Arun Kumar K)
Date: Tue, 17 Dec 2013 13:33:34 +0530
Subject: [PATCH 3/3] cpufreq: exynos: Add exynos5420 cpufreq driver
In-Reply-To: <CAKohpo=vkZRSQ5Xk-Tsm9QVy8h2F5Ehpm4Y8JWi5xjx0OD72tw@mail.gmail.com>
References: <1386323284-15646-1-git-send-email-arun.kk@samsung.com>
 <1386323284-15646-4-git-send-email-arun.kk@samsung.com>
 <CAKohpo=vkZRSQ5Xk-Tsm9QVy8h2F5Ehpm4Y8JWi5xjx0OD72tw@mail.gmail.com>
Message-ID: <CALt3h7-KWS6Nd0tfESz+1-ce1y1jY+0Op2UzcAoDCf2DxgHm8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

Thank you for the review.

On Tue, Dec 17, 2013 at 11:42 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 6 December 2013 15:18, Arun Kumar K <arun.kk@samsung.com> wrote:
>> From: "Arjun.K.V" <arjun.kv@samsung.com>
>>
>> The patch adds cpufreq driver for exynos5420.
>>
>> Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
>> ---
>>  drivers/cpufreq/Kconfig.arm          |   11 ++
>>  drivers/cpufreq/Makefile             |    1 +
>>  drivers/cpufreq/exynos-cpufreq.c     |    2 +
>>  drivers/cpufreq/exynos-cpufreq.h     |    8 +
>>  drivers/cpufreq/exynos5420-cpufreq.c |  346 ++++++++++++++++++++++++++++++++++
>>  5 files changed, 368 insertions(+)
>>  create mode 100644 drivers/cpufreq/exynos5420-cpufreq.c
>
> Hmm.. That's the second big LITTLE SoC after TC2..
> And we already have a generic enough driver for all big LITTLE platforms:
> arm_big_little.c
>
> Please use that with a glue clk and regulator driver if required. We don't
> want to get any new driver for big LITTLE unless there is a real limitation.
>

I missed this generic implementation and will try to see if the exynos5420
driver fits well with this framework.

> Also, the generic big LITTLE driver supports IKS (In Kernel Switcher)
> which may or maynot be used by Exynos.
>

Exynos uses IKS also.

> @Lukasz: We can't use cpu0 driver here as we have multiple clusters here
> A7 and A15, and so there are two clock domains instead of one. That's why
> we have written big LITTLE driver.
>
> @Arun: And you logs must be a bit enhanced as well.. I knew 5420 is big
> LITTLE but others may not.. And hence please provide a summary of your
> platform whenever you add new drivers..
>

Sure, I will provide more description.

Regards
Arun
