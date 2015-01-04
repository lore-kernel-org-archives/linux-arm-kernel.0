From: tom.leiming@gmail.com (Ming Lei)
Date: Sun, 4 Jan 2015 10:57:27 +0800
Subject: kernel panic when booting on exynos 5440
In-Reply-To: <549BE7CC.1000005@samsung.com>
References: <CACVXFVNCZdMyHQ1fzZDGs7h7X9vWmMVBJFRqWs7_P=WBQUYk1g@mail.gmail.com>
 <549BE7CC.1000005@samsung.com>
Message-ID: <CACVXFVOVS=sVqxe3q3_SShxoTkHy+yi4+2Go9k4gqhUgBjiZFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

On Thu, Dec 25, 2014 at 6:32 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> +CC: Thomas Abraham
>
> Hi Ming,
>
> On Thursday 25 December 2014 02:18 PM, Ming Lei wrote:
>>
>> Hi Pankaj,
>>
>> In your commit fce9e5bb2(ARM: EXYNOS: Add support for
>> mapping PMU base address via DT), 'pmu_base_addr' is
>> only parsed for very limited machines from the table of
>> 'exynos_dt_pmu_match'.  For other boards, 'pmu_base_addr'
>> will keep its default value of null, then panic() is triggered.
>>
>
> Yes, it will.
> As exynos5440 DT does not have PMU device node, neither above mentioned
> patch added corresponding matching device_id.
> If I remember correctly, I might have missed this because exynos5440 DT was
> not having PMU node.
>
>> What do you think about the problem?
>
>
> I missed this part, and I should have taken care of this in original patch
> itself. Well as of now I can think of only one solution that if we really
> want to keep support for exynos5440 in mainline kernel, to avoid above issue
> we should skip pmu mapping for exynos5440. In this case following patch will
> do this work.
>
> Also I will like to know from Kukjin that what best can be done now.
> If he is OK with below solution I can post the same.
>
> ---------------------------------------------------------------
>
> Subject: [PATCH] ARM: EXYNOS: do not try to map PMU for exynos5440
>
> Commit id: 2e94ac42898f84d76e3c21dd91bc is not taking care
> of mapping of exynos5440 PMU register which will result in kernel panic.
> As of now let's avoid mapping of exynos5440 PMU.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Is there any opportunity to merge the fix? Or exynos5440 will not be
supported in future?


Thanks,
Ming Lei
