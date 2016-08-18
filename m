From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Aug 2016 15:10:39 +0200
Subject: [PATCH] ARM: dts: add PM8058 LEDs to the APQ8060 Dragonboard
In-Reply-To: <57B4D9D0.8070000@gmail.com>
References: <1471376759-9561-1-git-send-email-linus.walleij@linaro.org>
 <57B4D9D0.8070000@gmail.com>
Message-ID: <CACRpkdYHu1rj81=_miq6Rtb+mkbdPSvULau0ojDC74wPo7hDAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 11:40 PM, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:

>> +                               led at 48 {
>> +                                       /*
>> +                                        * The keypad LED @0x48 is routed
>> to
>> +                                        * the sensor board where it is
>> +                                        * connected to an infrared LED
>> +                                        * SFH4650 (60mW, @850nm) next to
>> the
>> +                                        * ambient light and proximity
>> sensor
>> +                                        * Capella Microsystems CM3605.
>> +                                        */
>> +                                       compatible =
>> "qcom,pm8058-keypad-led";
>> +                                       reg = <0x48>;
>> +                                       label = "proximity0";
>
>
> In DT bindings documentation it was changed to "pm8050:white:keypad" to
> adhere to the LED class device naming convention. I assume that having
> it in this form is an omission here.

Hm right. Given the usecase here, what do you say about naming
it:

"pm8058:infrared:proximitysensor"

?

Yours,
Linus Walleij
