From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 27 Nov 2014 21:14:59 +0900
Subject: [PATCH 01/19] pinctrl: exynos: Add support for Exynos5433
In-Reply-To: <3904347.Bp2gmpYM49@wuerfel>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <1417073716-22997-2-git-send-email-cw00.choi@samsung.com>
 <3904347.Bp2gmpYM49@wuerfel>
Message-ID: <CA+Ln22FtvUD1HqH9PCGPCRu8Cyc6u4oNnsrEWyKYODtCT8wKHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-27 20:45 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 27 November 2014 16:34:58 Chanwoo Choi wrote:
>> +
>> +/*
>> + * Samsung pinctrl driver data for Exynos5433 SoC. Exynos5433 SoC includes
>> + * four gpio/pin-mux/pinconfig controllers.
>> + */
>> +struct samsung_pin_ctrl exynos5433_pin_ctrl[] = {
>> +       {
>> +               /* pin-controller instance 0 data */
>> +               .pin_banks      = exynos5433_pin_banks0,
>> +               .nr_banks       = ARRAY_SIZE(exynos5433_pin_banks0),
>> +               .eint_wkup_init = exynos_eint_wkup_init,
>> +               .suspend        = exynos_pinctrl_suspend,
>> +               .resume         = exynos_pinctrl_resume,
>> +               .label          = "exynos5433-gpio-ctrl0",
>> +       }, {
>>
>
> I'm counting nine controllers, not four ;-)
>
> These seem to all be fairly regular,

Yup, especially considering what Chanwoo mentioned about the great
idea someone came up with about putting EINT registers of one of the
controllers in different pin controller.

> my impression is that with the
> move to arm64, you should come up with a new binding that can fully
> describe each controller so you don't have to add new code and bindings
> for each future SoC that uses the same scheme.

Still, this is exactly the same thing I thought when initially refactoring this
driver 2 years ago and what was dismissed at that time due to people
supposedly not wanting that much data in DT. If this point of view has changed,
then I fully support your view, though.

Best regards,
Tomasz
