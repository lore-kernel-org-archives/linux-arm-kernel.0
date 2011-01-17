From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 17 Jan 2011 09:38:59 -0800
Subject: [PATCH] ARM: colibri-pxa300: use correct SD detect pin
In-Reply-To: <AANLkTi=GsjHq+e2yFWiRveX2MJqbFq4DaB52yYnYKQn7@mail.gmail.com>
References: <1293116462-10189-1-git-send-email-bjorn.forsman@gmail.com>
	<AANLkTi=GsjHq+e2yFWiRveX2MJqbFq4DaB52yYnYKQn7@mail.gmail.com>
Message-ID: <AANLkTimyEczJtEo8upfpLTMwQUmpoTByeCe60m7DWHQO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/15 Bj?rn Forsman <bjorn.forsman@gmail.com>:
> 2010/12/23 Bj?rn Forsman <bjorn.forsman@gmail.com>:
>> The use of wrong SD detect pin was introduced by this commit:
>>
>> ?ARM: pxa: Push Colibri evalboard MFP into module files
>>
>> This fixes it.

Applied.

>> ---
>> ?arch/arm/mach-pxa/colibri-evalboard.c ? ?| ? ?2 +-
>> ?arch/arm/mach-pxa/colibri-pxa300.c ? ? ? | ? ?2 +-
>> ?arch/arm/mach-pxa/include/mach/colibri.h | ? ?2 +-
>> ?3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/colibri-evalboard.c b/arch/arm/mach-pxa/colibri-evalboard.c
>> index 6b2c800..28f667e 100644
>> --- a/arch/arm/mach-pxa/colibri-evalboard.c
>> +++ b/arch/arm/mach-pxa/colibri-evalboard.c
>> @@ -50,7 +50,7 @@ static void __init colibri_mmc_init(void)
>> ? ? ? ? ? ? ? ? ? ? ? ?GPIO0_COLIBRI_PXA270_SD_DETECT;
>> ? ? ? ?if (machine_is_colibri300()) ? ?/* PXA300 Colibri */
>> ? ? ? ? ? ? ? ?colibri_mci_platform_data.gpio_card_detect =
>> - ? ? ? ? ? ? ? ? ? ? ? GPIO39_COLIBRI_PXA300_SD_DETECT;
>> + ? ? ? ? ? ? ? ? ? ? ? GPIO13_COLIBRI_PXA300_SD_DETECT;
>> ? ? ? ?else ? ? ? ? ? ? ? ? ? ? ? ? ? ?/* PXA320 Colibri */
>> ? ? ? ? ? ? ? ?colibri_mci_platform_data.gpio_card_detect =
>> ? ? ? ? ? ? ? ? ? ? ? ?GPIO28_COLIBRI_PXA320_SD_DETECT;
>> diff --git a/arch/arm/mach-pxa/colibri-pxa300.c b/arch/arm/mach-pxa/colibri-pxa300.c
>> index fddb16d..66dd81c 100644
>> --- a/arch/arm/mach-pxa/colibri-pxa300.c
>> +++ b/arch/arm/mach-pxa/colibri-pxa300.c
>> @@ -41,7 +41,7 @@ static mfp_cfg_t colibri_pxa300_evalboard_pin_config[] __initdata = {
>> ? ? ? ?GPIO4_MMC1_DAT1,
>> ? ? ? ?GPIO5_MMC1_DAT2,
>> ? ? ? ?GPIO6_MMC1_DAT3,
>> - ? ? ? GPIO39_GPIO, ? ?/* SD detect */
>> + ? ? ? GPIO13_GPIO, ? ?/* GPIO13_COLIBRI_PXA300_SD_DETECT */
>>
>> ? ? ? ?/* UHC */
>> ? ? ? ?GPIO0_2_USBH_PEN,
>> diff --git a/arch/arm/mach-pxa/include/mach/colibri.h b/arch/arm/mach-pxa/include/mach/colibri.h
>> index 388a96f..cb4236e 100644
>> --- a/arch/arm/mach-pxa/include/mach/colibri.h
>> +++ b/arch/arm/mach-pxa/include/mach/colibri.h
>> @@ -60,7 +60,7 @@ static inline void colibri_pxa3xx_init_nand(void) {}
>> ?#define GPIO113_COLIBRI_PXA270_TS_IRQ ?113
>>
>> ?/* GPIO definitions for Colibri PXA300/310 */
>> -#define GPIO39_COLIBRI_PXA300_SD_DETECT ? ? ? ?39
>> +#define GPIO13_COLIBRI_PXA300_SD_DETECT ? ? ? ?13
>>
>> ?/* GPIO definitions for Colibri PXA320 */
>> ?#define GPIO28_COLIBRI_PXA320_SD_DETECT ? ? ? ?28
>> --
>> 1.7.0.4
>>
>>
>
> Ping?
>
