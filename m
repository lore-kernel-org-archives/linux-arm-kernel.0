From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Jun 2017 00:10:56 +0200
Subject: [PATCH] pinctrl: qcom: qdf2xxx: expose only some GPIO pins
In-Reply-To: <d5cb17b6-083a-58a0-caa6-01ee06ff1fd4@codeaurora.org>
References: <1498164850-4738-1-git-send-email-timur@codeaurora.org>
 <CACRpkdZeDjS_g27=1e7uCmFpjnqX+sDSu5G2VAuwFr_GJW1mug@mail.gmail.com>
 <d5cb17b6-083a-58a0-caa6-01ee06ff1fd4@codeaurora.org>
Message-ID: <CACRpkda-3g6ZpL7A8fcch_qFpYWuJkF1W6HHHdXJADN1G=FrKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 9:37 PM, Timur Tabi <timur@codeaurora.org> wrote:
> On 06/23/2017 07:33 AM, Linus Walleij wrote:
>>
>> I think using "lsgpio" fron tools/gpio/lsgpio.c is better to inspect
>> the available GPIOs.
>>
>> If you haven't tested the GPIO tools, please try it out.
>
>
> Unfortunately, this tool isn't very useful:
>
> $ sudo ./lsgpio
> GPIO chip: gpiochip0, "QCOM8001:00", 150 GPIO lines
>         line  0: unnamed unused [output]
>         line  1: unnamed unused [output]
>         line  2: unnamed unused [output]

They can be given reasonable names using the line-names
property in the DTS file, preferably the top-level file.
arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
is a good example.

Do the same with your target board and things will
be very much more helpful.

gpio-hammer can help you test a line (try it with
a LED) and gpio-event-mon can help you listen
at a key for example.

Yours,
Linus Walleij
