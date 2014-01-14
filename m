From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jan 2014 11:16:45 +0100
Subject: [PATCH v4 2/4] pinctrl: Add pinctrl binding for Broadcom Capri
 SoCs
In-Reply-To: <52CC6782.4060309@broadcom.com>
References: <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-3-git-send-email-syin@broadcom.com>
 <CACRpkdaAq15wKD900SqN1sQFLBATiuA3vNoua+KJGHU+gdCgqg@mail.gmail.com>
 <52CC6782.4060309@broadcom.com>
Message-ID: <CACRpkdYyz+zrzt0y135Wcq-yUMhiHOb1ov15+SsnVOcZvad96g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 7, 2014 at 9:45 PM, Sherman Yin <syin@broadcom.com> wrote:
> On 14-01-07 09:15 AM, Linus Walleij wrote:

> Is that what you wanted to see in pinctrl-bindings.txt, or is there
> something else you want to see added to that txt file?  I didn't want to add
> the description of slew-rate arguments there because this is capri-specific.
> I'm not quite sure what else to add.
(...)
> That doc already says bias-pull-up is specified in Ohm, and the specific
> values are chip-specific, so I don't think they should be mentioned there.

You're right, forget about this. I didn't realize the pinctrl bindings doc
was that good...

>>> +Optional Properties (for HDMI pins):
>>> +
>>> +- function:                    String. Specifies the pin mux selection.
>>> Values
>>> +                               must be one of: "alt1", "alt2", "alt3",
>>> "alt4"
>>> +- slew-rate:                   Integer. Controls slew rate.
>>> +                                       0: Standard(100kbps)&
>>> Fast(400kbps) mode
>>> +                                       1: Highspeed (3.4Mbps) mode
>>
>> Hmmmm slew rate is not specifiec in "bps" but rather in
>> something like volts per second. But maybe it's best to keep
>> this value driver-specific.
>
> Right, I think the slew-rates values are capri specific.

OK

Yours,
Linus Walleij
