From: pbrobinson@gmail.com (Peter Robinson)
Date: Tue, 12 Aug 2014 15:25:31 +0100
Subject: [PATCH] ARM: dts: Only build dtb if associated Arch and/or SoC is
 enabled
In-Reply-To: <1407853179.4724.4.camel@weser.hi.pengutronix.de>
References: <1407852078-31309-1-git-send-email-pbrobinson@gmail.com>
 <1407853179.4724.4.camel@weser.hi.pengutronix.de>
Message-ID: <CALeDE9MMJBbs87oVsHV39tez6Eafg745GSWng-9QdnKV1FKJqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 3:19 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Dienstag, den 12.08.2014, 15:01 +0100 schrieb Peter Robinson:
>> A number of arches (EXYNOS/IMX/TEGRA) are separated out into finer
>> grained definitions whether it be sub ARCH or SOC definitions. The
>> device tree blobs should only be built if the specific option is
>> enabled that supports that device or it might be that there's an
>> expectation that the device is supported when in actual fact it's
>> not. This ensures only the relevant bits are built.
>>
>> This also helps to avoid trivial merge conflicts when adding support
>> for new boards.
>>
>> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
>
> a small nitpick below, otherwise:
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
>
>> ---
>>  arch/arm/boot/dts/Makefile | 50 +++++++++++++++++++++++++++-------------------
>>  1 file changed, 30 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index b8c5cd3..e95808e 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -64,7 +64,7 @@ dtb-$(CONFIG_ARCH_BRCMSTB) += \
>>  dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
>>       da850-evm.dtb
>>  dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
>> -dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>> +dtb-$(CONFIG_ARCH_EXYNOS4) += exynos4210-origen.dtb \
>>       exynos4210-smdkv310.dtb \
>>       exynos4210-trats.dtb \
>>       exynos4210-universal_c210.dtb \
>> @@ -74,8 +74,8 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>
> I would argue that things look a little more consistent with the
> linebreak directly behind the "+=", as with the IMX entries. Maybe if
> other platform maintainers agree we could change this while touching
> things anyway. But this is only a small nitpick, so feel free to ignore.

I agree but I left it as each platform had it to save extra churn as I
wasn't sure what the exact convention was.

Peter
