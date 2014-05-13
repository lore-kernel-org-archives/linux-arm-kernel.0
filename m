From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 13 May 2014 15:44:00 +0530
Subject: [PATCH V3 2/3] ARM: EXYNOS5: Add Suspend-to-RAM support for 5420
In-Reply-To: <8537431.uXYiuaPHBe@amdc1032>
References: <1399546368-30537-1-git-send-email-vikas.sajjan@samsung.com>
 <8537431.uXYiuaPHBe@amdc1032>
Message-ID: <CAM4voakJyOqpECEbtSc=BrsMqb=c90-t-i4_m3F4wKqrEarH_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

[...]
>>
>> -     regmap_write(pmu_regmap, S5P_PAD_RET_MAUDIO_OPTION, (1 << 28));
>> -     regmap_write(pmu_regmap, S5P_PAD_RET_GPIO_OPTION, (1 << 28));
>> -     regmap_write(pmu_regmap, S5P_PAD_RET_UART_OPTION, (1 << 28));
>> -     regmap_write(pmu_regmap, S5P_PAD_RET_MMCA_OPTION, (1 << 28));
>> -     regmap_write(pmu_regmap, S5P_PAD_RET_MMCB_OPTION, (1 << 28));
>> -     regmap_write(pmu_regmap, S5P_PAD_RET_EBIA_OPTION, (1 << 28));
>> -     regmap_write(pmu_regmap, S5P_PAD_RET_EBIB_OPTION, (1 << 28));
>> +     if (soc_is_exynos5250()) {
>
> Adding a check here for EXYNOS5250 doesn't look correct (the old code
> behavior for older EXYNOS SoCs should be preserved).
Will fix this in the next version.

Regards,
Abhilash
