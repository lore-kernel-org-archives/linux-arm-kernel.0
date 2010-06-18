From: adrian.wenl@gmail.com (Lei Wen)
Date: Fri, 18 Jun 2010 16:56:24 +0800
Subject: [PATCH 08/25] mmp: add nand support to pxa168
In-Reply-To: <AANLkTilOIds0GEPmTWgi_y7UzJT4g9qx6iAtDJDgVxWu@mail.gmail.com>
References: <AANLkTinxMQjZIG4G1d9WVOiUX8-zHjTuTc1eRuInDRGW@mail.gmail.com>
	<AANLkTilOIds0GEPmTWgi_y7UzJT4g9qx6iAtDJDgVxWu@mail.gmail.com>
Message-ID: <AANLkTimzn6YyOX8CuCJ2UbchRtHjrrhWxkAL_s4gZovG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 18, 2010 at 2:59 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Fri, Jun 18, 2010 at 1:34 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> From 55adf11cb4ba8ba0b88148c9bce0cc08f94b97bd Mon Sep 17 00:00:00 2001
>> From: Lei Wen <leiwen@marvell.com>
>> Date: Mon, 31 May 2010 14:57:49 +0800
>> Subject: [PATCH 08/25] mmp: add nand support to pxa168
>>
>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>> ---
>> ?arch/arm/configs/pxa168_defconfig | ? ?9 ++++++++-
>> ?drivers/mtd/nand/Kconfig ? ? ? ? ?| ? ?2 +-
>> ?2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/configs/pxa168_defconfig
>> b/arch/arm/configs/pxa168_defconfig
>> index 113511f..a01ea99 100644
>> --- a/arch/arm/configs/pxa168_defconfig
>> +++ b/arch/arm/configs/pxa168_defconfig
>> @@ -438,7 +438,14 @@ CONFIG_EXTRA_FIRMWARE=""
>> ?# CONFIG_DEBUG_DEVRES is not set
>> ?# CONFIG_SYS_HYPERVISOR is not set
>> ?# CONFIG_CONNECTOR is not set
>> -# CONFIG_MTD is not set
>> +CONFIG_MTD=y
>> +CONFIG_MTD_PARTITIONS=y
>> +CONFIG_MTD_CMDLINE_PARTS=y
>> +CONFIG_MTD_CHAR=y
>> +CONFIG_MTD_BLKDEVS=y
>> +CONFIG_MTD_BLOCK=y
>> +CONFIG_MTD_NAND=y
>> +CONFIG_MTD_NAND_PXA3xx=y
>> ?# CONFIG_PARPORT is not set
>> ?# CONFIG_BLK_DEV is not set
>> ?# CONFIG_MISC_DEVICES is not set
>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
>> index 9a35d92..0d29b5d 100644
>> --- a/drivers/mtd/nand/Kconfig
>> +++ b/drivers/mtd/nand/Kconfig
>> @@ -394,7 +394,7 @@ endchoice
>>
>> ?config MTD_NAND_PXA3xx
>> ? ? ? ?tristate "Support for NAND flash devices on PXA3xx"
>> - ? ? ? depends on MTD_NAND && (PXA3xx || ARCH_MMP)
>> + ? ? ? depends on MTD_NAND && PLAT_PXA
>
> I'd prefer this not being changed, as pxa3xx_nand isn't applicable to
> pxa25x/pxa27x.
>

I see... I would remove that change
