From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 10 Apr 2013 14:52:30 +0800
Subject: [PATCH] ARM: pxa: move debug uart code
In-Reply-To: <51650AE7.5050701@compulab.co.il>
References: <1365567243-17872-1-git-send-email-haojian.zhuang@linaro.org>
 <51650AE7.5050701@compulab.co.il>
Message-ID: <CAN1soZyrDOv=YpxkH73dFLqQviGjTgJc534ccicgpwOyaeUR3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 2:47 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> On 04/10/13 07:14, Haojian Zhuang wrote:
>> Move debug uart code from mach-pxa/mach-mmp to debug directory.
>> Since they are similar, merge them together.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  arch/arm/Kconfig.debug                       |    9 +++++++
>>  arch/arm/include/debug/pxa.S                 |   33 ++++++++++++++++++++++++++
>>  arch/arm/mach-mmp/include/mach/debug-macro.S |   30 -----------------------
>>  arch/arm/mach-pxa/include/mach/debug-macro.S |   23 ------------------
>>  4 files changed, 42 insertions(+), 53 deletions(-)
>>  create mode 100644 arch/arm/include/debug/pxa.S
>>  delete mode 100644 arch/arm/mach-mmp/include/mach/debug-macro.S
>>  delete mode 100644 arch/arm/mach-pxa/include/mach/debug-macro.S
>>
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 2bf1973..2267ff7 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -330,6 +330,13 @@ choice
>>                 Say Y here if you want kernel low-level debugging support
>>                 on PicoXcell based platforms.
>>
>> +     config DEBUG_PXA_UART1
>> +             depends on ARCH_PXA
>> +             bool "Use PXA UAR0 for low-level debug"
>
> s/UAR0/UART0/
Yes, it should be UART1. It's a typo error.

>
>> +             help
>> +               Say Y here if you want kernel low-level debugging support
>> +               on PXA UART1.
>> +
>>       config DEBUG_REALVIEW_STD_PORT
>>               bool "RealView Default UART"
>>               depends on ARCH_REALVIEW
>
> [...]
>
>
> --
> Regards,
> Igor.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
