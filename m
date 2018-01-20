From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 20 Jan 2018 11:10:42 +0800
Subject: [linux-sunxi] [RFC PATCH 2/9] ARM: sunxi: add Allwinner ARMv5 SoCs
In-Reply-To: <CAGRGNgUjvvzseAtUuiy5xCaZrLw2Jq4+A_dPXR9r_Xs-yYL1cw@mail.gmail.com>
References: <20180119231735.61504-1-icenowy@aosc.io>
 <20180119231735.61504-3-icenowy@aosc.io>
 <CAGRGNgUjvvzseAtUuiy5xCaZrLw2Jq4+A_dPXR9r_Xs-yYL1cw@mail.gmail.com>
Message-ID: <76DC4CD7-4A07-40C7-80A8-1C2D177E8109@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?1?20? GMT+08:00 ??11:06:40, Julian Calaby <julian.calaby@gmail.com> ??:
>Hi Icenowy,
>
>On Sat, Jan 20, 2018 at 10:17 AM, Icenowy Zheng <icenowy@aosc.io>
>wrote:
>> Add option for Allwinner ARMv5 SoCs and a SoC suniv (which is a die
>used
>> for many new F-series products, including F1C100A, F1C100s, F1C200s,
>> F1C500, F1C600).
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  arch/arm/mach-sunxi/Kconfig    | 13 +++++++++++++
>>  arch/arm/mach-sunxi/Makefile   |  1 +
>>  arch/arm/mach-sunxi/sunxi_v5.c | 22 ++++++++++++++++++++++
>>  3 files changed, 36 insertions(+)
>>  create mode 100644 arch/arm/mach-sunxi/sunxi_v5.c
>>
>> diff --git a/arch/arm/mach-sunxi/Kconfig
>b/arch/arm/mach-sunxi/Kconfig
>> index 65509a35935f..78ac9ce70641 100644
>> --- a/arch/arm/mach-sunxi/Kconfig
>> +++ b/arch/arm/mach-sunxi/Kconfig
>> @@ -59,3 +59,16 @@ config MACH_SUN9I
>>         select ARM_GIC
>>
>>  endif
>> +
>> +menuconfig ARCH_SUNXI_V5
>> +       bool "Allwinner SoCs"
>
>That name seems a little too generic. Maybe "Allwinner ARMv5 SoCs"?

This is already required by armv5.

Allwinner currently has only ARMv5,7,8 SoCs. ARMv8 is under
arm64 architecture, and ARMv5 and v7 cannot be selected at the same time.

>
>Thanks,
