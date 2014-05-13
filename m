From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Tue, 13 May 2014 15:44:23 +0530
Subject: [PATCH V3 2/3] ARM: EXYNOS5: Add Suspend-to-RAM support for 5420
In-Reply-To: <536DABB3.4060809@samsung.com>
References: <1399546368-30537-1-git-send-email-vikas.sajjan@samsung.com>
 <536DABB3.4060809@samsung.com>
Message-ID: <CAM4voa=T0Pq-evFT7o8f53QnK_Lqp6ke1rGAreSPd9JcvyFPNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

[...]
>>   +#define EXYNOS5420_VA_CPU_STATE (S5P_VA_SYSRAM + 0x28)
>> +#define EXYNOS5420_VA_CPU_ADDR  (S5P_VA_SYSRAM_NS + 0x1C)
>> +
>
>
> It will be good if we can rebase this change on top of Sachin's SYSRAM
> patches [1]
>
> [1]: http://www.spinics.net/lists/arm-kernel/msg329188.html
This is now merged in Kukjin's for-next. Have rebased my patches on top of it.

[...]
>> +
>> +               unsigned i;
>> +
>> +               s3c_pm_do_save(exynos5420_reg_save,
>> +                       ARRAY_SIZE(exynos5420_reg_save));
>> +
>
>
> Is it possible to move this code in DISP driver somewhere?
> As if you see I have already posted some patches [1] to remove i2c SYS CFG
> register
> configuration during S2R from pm.c to i2c driver itself for Exynos5250 as
> suggested
> by Arnd.
>
> This way we can reduce dependency of regs-sys.h in pm.c also we do not need
> to
> statically map sysreg register in exynos.c, and in general it will us in
> cleaning up
> exynos code from such things as it is being discussed here [2]
>
> [1]: https://lkml.org/lkml/2014/5/6/104
> [2]: https://lkml.org/lkml/2014/5/6/71
Will remove.

[...]
>>     /* For EXYNOS5 */
>>   +#define EXYNOS5_SYS_DISP1_BLK_CFG
>> S5P_SYSREG(0x0214)
>
>
> I think this offset should not be added here as it does not belong with PMU.
> Moreover IIRC if you have rebased these patches on my Exynos PMU patch
> series [1],
> this change should fail to compile as "regs-pmu.h" does not have anymore
> "mach/map.h" and definition for S5P_SYSREG has been moved to a new file
> "regs-sys.h". Please check here [2]
>
> [1]: https://lkml.org/lkml/2014/5/2/612
> [2]: https://lkml.org/lkml/2014/4/30/8
Will remove.
>
>
>>   #define EXYNOS5_AUTO_WDTRESET_DISABLE                         (0x0408)
>>   #define EXYNOS5_MASK_WDTRESET_REQUEST                         (0x040C)
>>
>
>
>
> --
> Best Regards,
> Pankaj Dubey
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
