From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Oct 2015 14:35:00 +0200
Subject: [PATCH v2 3/9] includes: dt-bindings: Add STM32F429 pinctrl DT
 bindings
In-Reply-To: <CALszF6DQ2G_Fzhk_SP+A0i_Z4mg9etdf1NcfQS3cPpB0zNot-w@mail.gmail.com>
References: <1445102604-11502-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1445102604-11502-4-git-send-email-mcoquelin.stm32@gmail.com>
 <56261239.5030007@linaro.org>
 <CALszF6DQ2G_Fzhk_SP+A0i_Z4mg9etdf1NcfQS3cPpB0zNot-w@mail.gmail.com>
Message-ID: <CACRpkdashSEWL+KFgD+MmdoZwjXnsXpxy-MPmDciO9n87+6BBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 6:32 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:
> 2015-10-20 12:06 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
>> On 17/10/15 18:23, Maxime Coquelin wrote:

>> I suggesting that, like with the clock driver, there is no need to the
>> STM32F429_PAXX_FUNC_YYY macros at all.
>>
>> Given the way you can enumerate pin config options in stm32f429.dtsi then I
>> think stm32f429.dtsi is the only file that will ever include this header? If
>> so then why not just plug the values directly into the pinmux fields. Its
>> not duplicative and is easier to map back to data sheets.
>>
>> ~~~
>> #define PIN_NO(x) ...
>> #define PIN_AF(x) ...
>>
>> usart1_pins_a: usart1 at 0 {
>>                                 pins1 {
>>                                         pinmux = PIN_NO(9) | PIN_AF(7);
>>                                         bias-disable;
>>                                         drive-push-pull;
>>                                         slew-rate = <0>;
>>                                 };
>>                                 ...
>>                         };
>> ~~~
>
> The advantage with the defines is that you can see easily which pin we
> are talking about.
> Moreover, the defines are generated from the datasheet, so it is
> painless to generate them.
> And it will be consistent with Mediatek implementation, on which I
> heavily inspired.
>
> Linus, what is your view?

I have no strong view of this at all.

I would ask the opinion of other people doing numbered muxes
to see what is generally best for everyone to use,
Sascha Hauer specifically, or the Mediatek people.

Yours,
Linus Walleij
