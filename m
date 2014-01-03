From: r.sh.open@gmail.com (Rahul Sharma)
Date: Fri, 3 Jan 2014 14:56:18 +0530
Subject: [PATCH 2/7] pinctrl: exynos: add exynos5260 SoC specific data
In-Reply-To: <1548210.PeZ57k2d5L@amdc1227>
References: <1386345391-23482-1-git-send-email-rahul.sharma@samsung.com>
 <1386345391-23482-3-git-send-email-rahul.sharma@samsung.com>
 <1548210.PeZ57k2d5L@amdc1227>
Message-ID: <CAPdUM4Pjx3eHoMQJ=vfaxNy9sPTiQzeemPDAJuHkXTYEqU4T+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On 10 December 2013 21:34, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Young-Gun, Pankaj, Rahul, Arun,
>
> Please see my comments inline.
>
> On Friday 06 of December 2013 21:26:26 Rahul Sharma wrote:
>> From: Young-Gun Jang <yg1004.jang@samsung.com>
>>
>> Add Samsung Exynos5260 SoC specific data to enable pinctrl
>> support for all platforms based on EXYNOS5260.
> [snip]
>> diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
>> index 155b1b3..9a93df6 100644
>> --- a/drivers/pinctrl/pinctrl-exynos.c
>> +++ b/drivers/pinctrl/pinctrl-exynos.c
>> @@ -1042,6 +1042,88 @@ struct samsung_pin_ctrl exynos5250_pin_ctrl[] = {
>>       },
>>  };
>>
>> +/* pin banks of exynos5260 pin-controller 0 */
>> +static struct samsung_pin_bank exynos5260_pin_banks0[] = {
>> +     EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpa0", 0x00),
>> +     EXYNOS_PIN_BANK_EINTG(7, 0x020, "gpa1", 0x04),
>> +     EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
>> +     EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpb0", 0x0c),
>> +     EXYNOS_PIN_BANK_EINTG(4, 0x080, "gpb1", 0x10),
>> +     EXYNOS_PIN_BANK_EINTG(5, 0x0A0, "gpb2", 0x14),
>> +     EXYNOS_PIN_BANK_EINTG(8, 0x0C0, "gpb3", 0x18),
>> +     EXYNOS_PIN_BANK_EINTG(8, 0x0E0, "gpb4", 0x1c),
>> +     EXYNOS_PIN_BANK_EINTG(8, 0x100, "gpb5", 0x20),
>> +     EXYNOS_PIN_BANK_EINTG(8, 0x120, "gpd0", 0x24),
>> +     EXYNOS_PIN_BANK_EINTG(7, 0x140, "gpd1", 0x28),
>> +     EXYNOS_PIN_BANK_EINTG(5, 0x160, "gpd2", 0x2c),
>> +     EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpe0", 0x30),
>> +     EXYNOS_PIN_BANK_EINTG(5, 0x1A0, "gpe1", 0x34),
>> +     EXYNOS_PIN_BANK_EINTG(4, 0x1C0, "gpf0", 0x38),
>> +     EXYNOS_PIN_BANK_EINTG(8, 0x1E0, "gpf1", 0x3c),
>> +     EXYNOS_PIN_BANK_EINTG(2, 0x200, "gpk0", 0x40),
>> +     EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
>> +     EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
>> +     EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
>> +     EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
>
> nit: Please use lowercase hexadecimal characters. Despite of already
> existing code, lowercase is the preferred way.
>

Changed.

>> +};
>> +
>> +/* pin banks of exynos5260 pin-controller 1 */
>> +static struct samsung_pin_bank exynos5260_pin_banks1[] = {
>> +     EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpc0", 0x00),
>> +     EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpc1", 0x04),
>> +     EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpc2", 0x08),
>> +     EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpc3", 0x0c),
>> +     EXYNOS_PIN_BANK_EINTG(4, 0x080, "gpc4", 0x10),
>> +};
>> +
>> +/* pin banks of exynos5260 pin-controller 2 */
>> +static struct samsung_pin_bank exynos5260_pin_banks2[] = {
>> +     EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
>> +     EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
>> +};
>> +
>> +/*
>> + * Samsung pinctrl driver data for Exynos5260 SoC. Exynos5420 SoC includes
>> + * four gpio/pin-mux/pinconfig controllers.
>
> Hmm, I can see only three of them below. Is there one left undefined?

There are only three. I updated the comment.

regards,
Rahul Sharma

>
> Otherwise, the patch looks fine.
>
> Best regards,
> Tomasz
>
