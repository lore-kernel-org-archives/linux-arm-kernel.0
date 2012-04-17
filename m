From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 17 Apr 2012 13:54:04 +0530
Subject: [PATCH 08/12] gpio/samsung: add GPC4 bank instance
In-Reply-To: <CAH9JG2VorCARJie+nrxh13-p0zTkboiRjkyMFpw8Eczb-9V-Bw@mail.gmail.com>
References: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
 <1334641595-25301-9-git-send-email-thomas.abraham@linaro.org>
 <CAH9JG2VorCARJie+nrxh13-p0zTkboiRjkyMFpw8Eczb-9V-Bw@mail.gmail.com>
Message-ID: <CAJuYYwQb2Ahzc-HX2qDFa6NoSmhp2C1KTtN7OQfMVc=zcUbn-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2012 12:03, Kyungmin Park <kmpark@infradead.org> wrote:
> On 4/17/12, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>> From: Sangsu Park <sangsu4u.park@samsung.com>
>>
>> Add GPC4 bank instance which is included in rev1 of Exynos5.
>>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
>> ---
>> ?arch/arm/mach-exynos/include/mach/gpio.h | ? ?9 ++++++---
>> ?drivers/gpio/gpio-samsung.c ? ? ? ? ? ? ?| ? ?8 ++++++++
>> ?2 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/include/mach/gpio.h
>> b/arch/arm/mach-exynos/include/mach/gpio.h
>> index d7498af..df5612b 100644
>> --- a/arch/arm/mach-exynos/include/mach/gpio.h
>> +++ b/arch/arm/mach-exynos/include/mach/gpio.h
>> @@ -153,10 +153,11 @@ enum exynos4_gpio_number {
>> ?#define EXYNOS5_GPIO_B2_NR ? (4)
>> ?#define EXYNOS5_GPIO_B3_NR ? (4)
>> ?#define EXYNOS5_GPIO_C0_NR ? (7)
>> -#define EXYNOS5_GPIO_C1_NR ? (7)
>> +#define EXYNOS5_GPIO_C1_NR ? (4)
>> ?#define EXYNOS5_GPIO_C2_NR ? (7)
>> ?#define EXYNOS5_GPIO_C3_NR ? (7)
>> -#define EXYNOS5_GPIO_D0_NR ? (8)
>> +#define EXYNOS5_GPIO_C4_NR ? (8)
>> +#define EXYNOS5_GPIO_D0_NR ? (4)
>> ?#define EXYNOS5_GPIO_D1_NR ? (8)
>> ?#define EXYNOS5_GPIO_Y0_NR ? (6)
>> ?#define EXYNOS5_GPIO_Y1_NR ? (4)
>> @@ -199,7 +200,8 @@ enum exynos5_gpio_number {
>> ? ? ? EXYNOS5_GPIO_C1_START ? ? ? ? ? = EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C0),
>> ? ? ? EXYNOS5_GPIO_C2_START ? ? ? ? ? = EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C1),
>> ? ? ? EXYNOS5_GPIO_C3_START ? ? ? ? ? = EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C2),
>> - ? ? EXYNOS5_GPIO_D0_START ? ? ? ? ? = EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C3),
>> + ? ? EXYNOS5_GPIO_C4_START ? ? ? ? ? = EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C3),
>> + ? ? EXYNOS5_GPIO_D0_START ? ? ? ? ? = EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_C4),
>> ? ? ? EXYNOS5_GPIO_D1_START ? ? ? ? ? = EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_D0),
>> ? ? ? EXYNOS5_GPIO_Y0_START ? ? ? ? ? = EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_D1),
>> ? ? ? EXYNOS5_GPIO_Y1_START ? ? ? ? ? = EXYNOS_GPIO_NEXT(EXYNOS5_GPIO_Y0),
>> @@ -242,6 +244,7 @@ enum exynos5_gpio_number {
>> ?#define EXYNOS5_GPC1(_nr) ? ?(EXYNOS5_GPIO_C1_START + (_nr))
>> ?#define EXYNOS5_GPC2(_nr) ? ?(EXYNOS5_GPIO_C2_START + (_nr))
>> ?#define EXYNOS5_GPC3(_nr) ? ?(EXYNOS5_GPIO_C3_START + (_nr))
>> +#define EXYNOS5_GPC4(_nr) ? ?(EXYNOS5_GPIO_C4_START + (_nr))
>> ?#define EXYNOS5_GPD0(_nr) ? ?(EXYNOS5_GPIO_D0_START + (_nr))
>> ?#define EXYNOS5_GPD1(_nr) ? ?(EXYNOS5_GPIO_D1_START + (_nr))
>> ?#define EXYNOS5_GPY0(_nr) ? ?(EXYNOS5_GPIO_Y0_START + (_nr))
>> diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
>> index 4627787..0153bb9 100644
>> --- a/drivers/gpio/gpio-samsung.c
>> +++ b/drivers/gpio/gpio-samsung.c
>> @@ -2452,6 +2452,12 @@ static struct samsung_gpio_chip exynos5_gpios_1[] = {
>> ? ? ? ? ? ? ? },
>> ? ? ? }, {
>> ? ? ? ? ? ? ? .chip ? = {
>> + ? ? ? ? ? ? ? ? ? ? .base ? = EXYNOS5_GPC4(0),
>> + ? ? ? ? ? ? ? ? ? ? .ngpio ?= EXYNOS5_GPIO_C4_NR,
>> + ? ? ? ? ? ? ? ? ? ? .label ?= "GPC4",
>> + ? ? ? ? ? ? },
>> + ? ? }, {
>> + ? ? ? ? ? ? .chip ? = {
>> ? ? ? ? ? ? ? ? ? ? ? .base ? = EXYNOS5_GPD0(0),
>> ? ? ? ? ? ? ? ? ? ? ? .ngpio ?= EXYNOS5_GPIO_D0_NR,
>> ? ? ? ? ? ? ? ? ? ? ? .label ?= "GPD0",
>> @@ -2880,6 +2886,8 @@ static __init int samsung_gpiolib_init(void)
>> ? ? ? ? ? ? ? for (i = 0; i < 4; i++, chip++, gpx_base += 0x20)
>> ? ? ? ? ? ? ? ? ? ? ? chip->base = gpx_base;
>>
>> + ? ? ? ? ? ? exynos5_gpios_1[11].base = gpio_base1 + 0x2E0;
> '11' seems dangerous. I think you add comments here and above to know
> '11' meaning.

Yes, true. But these will go away when the Samsung pinctrl driver will
be merged. For now, I will put a comment to explain the meaning of 11.

Thanks for reviewing the patches.

Thanks,
Thomas.

>> +
>> ? ? ? ? ? ? ? chip = exynos5_gpios_1;
>> ? ? ? ? ? ? ? nr_chips = ARRAY_SIZE(exynos5_gpios_1);
>>
>> --
>> 1.6.6.rc2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
>> in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>>
