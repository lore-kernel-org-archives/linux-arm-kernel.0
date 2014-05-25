From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 May 2014 04:51:49 +0900
Subject: [PATCH] ARM: exynos: Fix kernel panic when unplugging CPU1 on 4210
In-Reply-To: <5380D77C.2020104@linaro.org>
References: <537FBE42.7050608@gmail.com>
 <1400952255-13750-1-git-send-email-daniel.lezcano@linaro.org>
 <5380D77C.2020104@linaro.org>
Message-ID: <538249D5.3040503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/14 02:31, Daniel Lezcano wrote:
> On 05/24/2014 07:24 PM, Daniel Lezcano wrote:
>> A look at the code reveals use of S5P_VA_SYSRAM macro, in case of
>> certain SoC
>> revisions, which is not valid any longer, after SYSRAM started to be
>> mapped
>> dynamically. The new dynamic mapping is stored in sysram_base_addr
>> variable,
>> which is declared static in platsmp.c
>>
>> This fix makes sysram_base_addr non-static, declared it in common.h
>> and used
>> in pm.c instead of S5P_VA_SYSRAM.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Suggested-by: Tomasz Figa <t.figa@samsung.com>
>
> Hi Kukjin,
>
> with this fix I confirm cpuidle is working well with the AFTR state on
> the exynos 4210.
>
Thanks a lot.

I've applied this fix on top of cpuidle-exynos branch.

- Kukjin
