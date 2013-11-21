From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Nov 2013 10:48:37 +0100
Subject: [PATCH 5/9] ARM: at91/dt: add mmc0 slot0 support to at91rm9200ek
 board
In-Reply-To: <528CDFFB.1020601@overkiz.com>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
 <1377687995-10758-1-git-send-email-b.brezillon@overkiz.com>
 <20131120145926.GE14627@ns203013.ovh.net>
 <528CDFFB.1020601@overkiz.com>
Message-ID: <CACRpkdboBg4YOnMNiar0DDBVnoky=zNky+Pzyp1=P_POtH15qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 5:14 PM, boris brezillon
<b.brezillon@overkiz.com> wrote:
> On 20/11/2013 15:59, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 13:06 Wed 28 Aug     , Boris BREZILLON wrote:

>>> mmc0_slot0_switch-0 {
>>> +                                               atmel,pins =
>>> +                                                       <AT91_PIOB 22
>>> AT91_PERIPH_GPIO (AT91_PINCTRL_OUTPUT | AT91_PINCTRL_OUTPUT_VAL(1))>;
>>> +                                       };
>>
>> nack this is a regulator the pinctrl API is not done for gpio default
>> value
>
> I know this can be represented as a regulator, but looking at the datasheet,
> this looks more like a switch than a regulator.

No matter whether it's a switch or a GPIO regulator it seems we
are in violent agreement that it should not be controlled by the
pin control states at least.

Start with making it a GPIO then you can figure out whether
a GPIO regulator or drivers/extcon/extcon-gpio.c should be
used.

Yours,
Linus Walleij
