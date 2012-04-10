From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 10 Apr 2012 09:56:29 -0700
Subject: [PATCH 4/4] ARM: Exynos5: Add PDMA and MDMA physical base address
 defines
In-Reply-To: <CAOesGMisDq_Z3zNFNmOeyDPEj-VXDsy9a8ABhJie4fsjtRkeJw@mail.gmail.com>
References: <1332840365-24827-1-git-send-email-thomas.abraham@linaro.org>
 <1332840365-24827-5-git-send-email-thomas.abraham@linaro.org>
 <4F73C0EC.60201@samsung.com>
 <CAOesGMisDq_Z3zNFNmOeyDPEj-VXDsy9a8ABhJie4fsjtRkeJw@mail.gmail.com>
Message-ID: <4F84663D.5070501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> Hi,
>
> 2012/3/28 Kukjin Kim<kgene.kim@samsung.com>:
>> Thomas Abraham wrote:
>>> Add PDMA and MDMA physical base address macros which is require for Exynos5
>>> of_dev_auxdata setup.
>>>
>>> Signed-off-by: Thomas Abraham<thomas.ab@samsung.com>
>>> ---
>>>    arch/arm/mach-exynos/include/mach/map.h |    5 +++++
>>>    arch/arm/mach-exynos/mach-exynos5-dt.c  |    3 ++-
>>>    2 files changed, 7 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
>>> index 024d38f..37d93fd 100644
>>> --- a/arch/arm/mach-exynos/include/mach/map.h
>>> +++ b/arch/arm/mach-exynos/include/mach/map.h
>>> @@ -90,6 +90,11 @@
>>>    #define EXYNOS4_PA_PDMA0            0x12680000
>>>    #define EXYNOS4_PA_PDMA1            0x12690000
>>>
>>> +#define EXYNOS5_PA_PDMA0             0x121A0000
>>> +#define EXYNOS5_PA_PDMA1             0x121B0000
>>> +#define EXYNOS5_PA_MDMA0             0x10800000
>>> +#define EXYNOS5_PA_MDMA1             0x11C10000
>>> +
>>
>> See, "ARM: EXYNOS: Support DMA for Exynos5250 SoC"
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/085434.html
>>
>> But this merge window is not including it :(
>
> Compilation of CONFIG_MACH_EXYNOS5_DT is broken without the above PDMA
> defines. Either add the defines, or remove the AUXDATA as part of the
> fixes for this release, please.
>
Yeah, right.

I fixed it with this but changed dma channel for mdma1.

@@ -45,7 +45,7 @@ static const struct of_dev_auxdata 
exynos5250_auxdata_lookup[]
                                 "exynos4210-uart.3", NULL),
         OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
         OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
-       OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.2", NULL),
+       OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
         {},
  };


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
