From: vigneshr@ti.com (Vignesh R)
Date: Tue, 5 Dec 2017 22:40:50 +0530
Subject: [PATCH] ARM: multi_v7_defconfig: Add configs for peripherals on
 Keystone2 SoCs
In-Reply-To: <fffba75f-6674-f293-d2c5-53eb477c0e76@oracle.com>
References: <20171205091940.22957-1-vigneshr@ti.com>
 <fffba75f-6674-f293-d2c5-53eb477c0e76@oracle.com>
Message-ID: <c2383f7c-a537-166a-de88-c6c8593beb83@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05-Dec-17 10:19 PM, Santosh Shilimkar wrote:
> On 12/5/2017 1:19 AM, Vignesh R wrote:
>> Enable Cadence QSPI present on 66AK2G SoC and Keystone USB PHY driver
>> for K2E.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>   arch/arm/configs/multi_v7_defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 992a8a5da065..c4f4f6682ea5 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -185,6 +185,7 @@ CONFIG_MTD_NAND_BRCMNAND=y
>>   CONFIG_MTD_NAND_VF610_NFC=y
>>   CONFIG_MTD_NAND_DAVINCI=y
>>   CONFIG_MTD_SPI_NOR=y
>> +CONFIG_SPI_CADENCE_QUADSPI=m
>>   CONFIG_SPI_FSL_QUADSPI=m
>>   CONFIG_MTD_UBI=y
>>   CONFIG_BLK_DEV_LOOP=y
>> @@ -675,6 +676,7 @@ CONFIG_USB_CHIPIDEA_HOST=y
>>   CONFIG_USB_ISP1760=y
>>   CONFIG_USB_HSIC_USB3503=y
>>   CONFIG_AB8500_USB=y
>> +CONFIG_KEYSTONE_USB_PHY=m
>>   CONFIG_NOP_USB_XCEIV=m
>>   CONFIG_USB_GPIO_VBUS=y
>>   CONFIG_USB_ISP1301=y
>>
> There are more peripherals/drivers which are enabled
> in keystone config.
> 
> PWM_TIECAP, CAN_C_CAN, RESET_TI_SYSCON, TI_SCI_PROTOCOL,
> TI_MESSAGE_MANAGER, NOP_USB_XCEIV, GPIO_PCA953X etc etc
> 
> Could please check the complete config and update the
> patch please ?
> 

On linux-next(on which this patch is based on) I see commit:
commit f15187dcdbcd8e649948a525153a356b35993655
Author: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Date:   Sat Dec 2 19:53:29 2017 -0800

    ARM: config: sync multi-v7 config with keystone peripherals

    Signed-off-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>


This commit enables all drivers for K2 platforms including the ones you
mentioned. I added the two missing ones in this patch.
There are some configs related to net which I am not sure whether to
enable or not and how it affects other platforms. But AFAICS, there are
no drivers left to be enabled.
