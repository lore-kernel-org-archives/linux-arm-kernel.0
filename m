From: olof@lixom.net (Olof Johansson)
Date: Fri, 12 Jul 2013 23:46:58 -0700
Subject: [PATCH] arm: multi_v7_defconfig: Tweaks for omap and sunxi
In-Reply-To: <51E0CEA8.2040201@elopez.com.ar>
References: <1373685174-7918-1-git-send-email-olof@lixom.net>
 <51E0CEA8.2040201@elopez.com.ar>
Message-ID: <CAOesGMjzhfQwhxDQv7ETAqu_fzE7WLzy-ydoxFWjLpcFpPeajw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 8:51 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> Hi Olof,
>
> El 13/07/13 00:12, Olof Johansson escribi?:
>> OMAP recently changed how the platforms are configured, so OMAP2/3/4 SoC
>> support is no longer enabled by default. Add them back.
>>
>> Enable new ethernet driver for sunxi.
>
> "ARM: multi_v7: Enable Allwinner EMAC in multi_v7_defconfig" by Maxime
> already does this, and is on Linus Torvalds' tree:
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=fb1c60288a886a28dc7c055449fd1936140fe891

No, it's been effectively reverted due to the driver not being in the
tree by the time the patch was merged, so if anyone ran savedefconfig
inbetween (which I did), the option was removed.

>> The i.MX console options moved due to resorting, no functional change.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>>
>> The OMAP changes are needed to deal with the dependency flip from OMAP2PLUS
>> being on and defaulting the SoCs accordingly, to the SoC options selecting
>> OMAP2PLUS. See the "ARM: OMAP2+: Remove board-4430sdp.c" for background.
>>
>>  arch/arm/configs/multi_v7_defconfig | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 80aacc6..fcd2b9b 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -15,8 +15,10 @@ CONFIG_SOC_IMX53=y
>>  CONFIG_SOC_IMX6Q=y
>>  CONFIG_SOC_IMX6SL=y
>>  CONFIG_SOC_VF610=y
>> -CONFIG_ARCH_OMAP2PLUS=y
>> +CONFIG_ARCH_OMAP3=y
>> +CONFIG_ARCH_OMAP4=y
>>  CONFIG_SOC_OMAP5=y
>> +CONFIG_SOC_AM33XX=y
>>  CONFIG_SOC_AM43XX=y
>>  CONFIG_ARCH_ROCKCHIP=y
>>  CONFIG_ARCH_SOCFPGA=y
>> @@ -57,6 +59,7 @@ CONFIG_SATA_AHCI_PLATFORM=y
>>  CONFIG_SATA_HIGHBANK=y
>>  CONFIG_SATA_MV=y
>>  CONFIG_NETDEVICES=y
>> +CONFIG_SUN4I_EMAC=y
>
> Additionally, this patch is missing CONFIG_MDIO_SUN4I=y, which I think
> would be needed to make CONFIG_SUN4I_EMAC=y of any use. Maybe a Kconfig
> select would be a good idea here?

Yes, likely. I can turn it on in the defconfig (I'll revise the
patch), but independent of that there should probably be a select for
the future.


-Olof
