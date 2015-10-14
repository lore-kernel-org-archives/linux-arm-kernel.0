From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 14 Oct 2015 16:46:26 +0200
Subject: [PATCH 0/3] hwrng: stm32 - add support for STM32 HW RNG
In-Reply-To: <20151014142822.GF17455@gondor.apana.org.au>
References: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
 <1444638090-22886-1-git-send-email-daniel.thompson@linaro.org>
 <20151014142822.GF17455@gondor.apana.org.au>
Message-ID: <CALszF6Db3mzM6xn2Tf4Bs65mGGY5UZspM3NniEC6eHei0oG1NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Herbert,

2015-10-14 16:28 GMT+02:00 Herbert Xu <herbert@gondor.apana.org.au>:
> On Mon, Oct 12, 2015 at 09:21:27AM +0100, Daniel Thompson wrote:
>> This patchset introduces a driver for the STM32 hardware random number
>> generator.
>>
>> v2:
>>
>>  * Moved binding docs from .../hwrng/ to .../rng/ and renamed to match
>>    convention in new directory (Rob Herring).
>>  * Adopted runtime PM and auto-suspend instead of managing the clocks
>>    from the read function (Linus Walleij). Increased bandwidth by ~30%.
>>  * Simplified error detection in main read loop (Linus Walleij, Maxime
>>    Coquelin).
>>  * Only WARN_ONCE() when hardware failure mechanisms trigger (Maxime
>>    Coquelin).
>>  * Simplify end of probe function after cocci warning (Fengguang Wu).
>>  * Switch to devm_hwrng_register.
>
> All applied.  Thanks!

I see you again have applied the DT patch like for STi three weeks ago.
The DT patch should go through the arm_soc tree to avoid Linus having
to handle conflicts resolution.

Can you please remove these two patches from your tree?
ba25d8b ARM: STi: STiH407: Enable the 2 HW Random Number Generators
for STiH4{07, 10}
b47c9fa ARM: dts: stm32f429: Adopt STM32 RNG driver

Thanks,
Maxime
