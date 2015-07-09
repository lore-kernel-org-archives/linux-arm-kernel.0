From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 09 Jul 2015 15:32:37 +0200
Subject: [PATCH 3/3] ARM: mvebu: update mvebu_v7_defconfig with features
 needed for Armada 388 GP
In-Reply-To: <55913F40.6070205@free-electrons.com>
References: <1434631121-32014-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1434631121-32014-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <55913F40.6070205@free-electrons.com>
Message-ID: <559E77F5.8070604@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 29/06/2015 14:51, Gregory CLEMENT wrote:
> Hi Thomas,
> 
> On 18/06/2015 14:38, Thomas Petazzoni wrote:
>> The Armada 388 GP board has the following hardware features that were
>> not enabled in mvebu_v7_defconfig:
>>
>>  * An AT24 I2C EEPROM (also used by armada-xp-lenovo-ix4-300d)
>>  * A PCA9555 I2C GPIO expander
>>  * Several fixed regulators
>>
>> Therefore, this commit adds the necessary options to mvebu_v7_defconfig.
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> 
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
applied on mvebu/config

Thanks,

Gregory

> Thanks,
> 
> Gregory
> 
>> ---
>>  arch/arm/configs/mvebu_v7_defconfig | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
>> index cacc9f4..13fcd02 100644
>> --- a/arch/arm/configs/mvebu_v7_defconfig
>> +++ b/arch/arm/configs/mvebu_v7_defconfig
>> @@ -58,6 +58,7 @@ CONFIG_MTD_M25P80=y
>>  CONFIG_MTD_NAND=y
>>  CONFIG_MTD_NAND_PXA3xx=y
>>  CONFIG_MTD_SPI_NOR=y
>> +CONFIG_EEPROM_AT24=y
>>  CONFIG_BLK_DEV_SD=y
>>  CONFIG_ATA=y
>>  CONFIG_AHCI_MVEBU=y
>> @@ -83,11 +84,14 @@ CONFIG_I2C_MV64XXX=y
>>  CONFIG_SPI=y
>>  CONFIG_SPI_ORION=y
>>  CONFIG_GPIO_SYSFS=y
>> +CONFIG_GPIO_PCA953X=y
>>  CONFIG_SENSORS_GPIO_FAN=y
>>  CONFIG_THERMAL=y
>>  CONFIG_ARMADA_THERMAL=y
>>  CONFIG_WATCHDOG=y
>>  CONFIG_ORION_WATCHDOG=y
>> +CONFIG_REGULATOR=y
>> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
>>  CONFIG_SOUND=y
>>  CONFIG_SND=y
>>  CONFIG_SND_SOC=y
>>
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
