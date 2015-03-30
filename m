From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Mar 2015 11:40:47 +0200
Subject: [PATCH] pinctrl: fsl: imx: Check for 0 config register
In-Reply-To: <139dc298c0914b3536445dddd37be286@agner.ch>
References: <1427210778-28037-1-git-send-email-mpa@pengutronix.de>
 <139dc298c0914b3536445dddd37be286@agner.ch>
Message-ID: <CACRpkdZ5UqTCHqXjBF5JWjmzHkbh2vwdDvTtn+UOkmrcmKxf9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 11:32 AM, Stefan Agner <stefan@agner.ch> wrote:
> On 2015-03-24 16:26, Markus Pargmann wrote:

>> 0 is used in all pinfunction definitions when a config register is not
>> available, for example imx25-pinfunc.h. If a configuration value is used
>> for such a pinfunction the driver will always write it to the
>> configuration register if it is not -1. For a 0 configuration register
>> the configuration value is written to offset 0x0. This can lead to a
>> crashing/hanging system without any warning message.
>
> 0 is a valid offset for Vybrid's mux register, however, since Vybrid set
> the SHARE_MUX_CONF_REG, intepreting a 0 in conf_reg as "not set"
> actually works.
>
> What is a bit a bummer is that we now have different meanings of 0,
> depending on the field:
> - For the first field (mux), 0 is a valid offset
> - For the second field (config), 0 means not valid

What is generally scary about DTS files is that the DT formats
are not ruled by a context-free grammar.

There were attempts to formalize some bindings using BNF
but they seems to have been given up.

We need to combat this by trying to be strict and logic ...
I can't really understand from the discussion here whether
the patch should be applied or not, so I'm not applying it
until Stefan | Uwe gives an explicit ACK.

Yours,
Linus Walleij
