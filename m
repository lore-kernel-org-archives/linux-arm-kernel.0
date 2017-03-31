From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Fri, 31 Mar 2017 11:06:14 +0530
Subject: [PATCH v9 04/12] soc: samsung: add exynos chipid driver support
In-Reply-To: <CAK8P3a0dq-Ve2N3yFbpZ7LHzZJ=w6-pLRTSZJZ2=rnk2gWphJw@mail.gmail.com>
References: <CGME20170330131427epcas5p4c3d238022dc75694ad3baa8a1018ea04@epcas5p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-5-git-send-email-pankaj.dubey@samsung.com>
 <CAK8P3a0dq-Ve2N3yFbpZ7LHzZJ=w6-pLRTSZJZ2=rnk2gWphJw@mail.gmail.com>
Message-ID: <a1be4b9c-0f68-dbe3-7799-d5acf4ec31e0@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thursday 30 March 2017 07:20 PM, Arnd Bergmann wrote:
> On Thu, Mar 30, 2017 at 3:16 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
>>
>> +config EXYNOS_CHIPID
>> +       bool "Exynos Chipid controller driver" if COMPILE_TEST
>> +       depends on ARCH_EXYNOS || COMPILE_TEST
>> +       select SOC_BUS
> 
> This lets you disable the driver when COMPILE_TEST is set on exynos,
> which is probably not what you wanted.
> 

Sorry I could not get this point. EXYNOS_CHIPID is invisible menu
option, when I enabled COMPILE_TEST, option is visible in make
menuconfig but it does not allow to disable this driver. I have adopted
this config same as EXYNOS_PMU in the same file.

> I'd do
> 
>          bool "Exynos Chipid controller driver" if COMPILE_TEST && !ARCHEXYNOS
>          default ARCH_EXYNOS

I can adopt, default ARCH_EXYNOS, which will allow me to drop patch 5/12
and 6/12.

Thanks for review.
Pankaj Dubey

> 
>      Arnd
> 
> 
> 
