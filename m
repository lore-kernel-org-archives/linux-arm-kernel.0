From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 9 Oct 2011 13:44:01 +0800
Subject: [PATCH 1/3] ARM: imx: always select CACHE_L2X0 on i.MX3
In-Reply-To: <20111009053905.GA24198@S2100-06.ap.freescale.net>
References: <20111004092015.GM31404@pengutronix.de>
	<20111008101322.GH31404@pengutronix.de>
	<109850802.HMOqKGRdrl@wuerfel> <101401532.609jSdenqo@wuerfel>
	<20111009053905.GA24198@S2100-06.ap.freescale.net>
Message-ID: <CAGsJ_4xBJx=BQPqE_TCBanWQZJUcgNpEUsyma48qi8qnY5OOiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/9 Shawn Guo <shawn.guo@freescale.com>:
> On Sat, Oct 08, 2011 at 05:15:50PM +0200, Arnd Bergmann wrote:
>> The i.MX3 and i.MX35 files unconditionally call the l2x0_init
>> function, so we should make sure that this is built into the
>> kernel.
>>
>> arch/arm/mach-imx/built-in.o: In function `imx3_init_l2x0':
>> mm-imx3.c:(.text+0x154): undefined reference to `l2x0_init'
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>
> However, this should also be fixed by the Rob Herring's patch below
> which I suppose it will be merged in the coming window.
>
> ?ARM: l2x0: add empty l2x0_of_init
>
> Anyway, your change makes sense to me, as the SoCs have L2 integrated
> and I see no reason that L2 can not be selected by default. ?I will
> do the same for my imx6q series to remove the dependency on Rob's
> patch.

the only loss is that users have to change Kconfig if they don't want
to open L2 for debugging purpose.

>
> Regards,
> Shawn
>
>> ?arch/arm/mach-imx/Kconfig | ? ?3 ++-
>> ?1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>> index 6c12836..3de9ac9 100644
>> --- a/arch/arm/mach-imx/Kconfig
>> +++ b/arch/arm/mach-imx/Kconfig
>> @@ -64,6 +64,7 @@ config SOC_IMX31
>> ? ? ? select ARCH_MXC_AUDMUX_V2
>> ? ? ? select ARCH_MX31
>> ? ? ? select MXC_AVIC
>> + ? ? select CACHE_L2X0
>>
>> ?config SOC_IMX35
>> ? ? ? bool
>> @@ -73,7 +74,7 @@ config SOC_IMX35
>> ? ? ? select HAVE_EPIT
>> ? ? ? select ARCH_MX35
>> ? ? ? select MXC_AVIC
>> -
>> + ? ? select CACHE_L2X0
>>
>> ?if ARCH_IMX_V4_V5
>>
>> --
>> 1.7.5.4

-barry
