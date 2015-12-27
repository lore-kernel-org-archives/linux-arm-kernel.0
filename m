From: torso.nafi@gmail.com (=?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?=)
Date: Sun, 27 Dec 2015 16:43:07 +0300
Subject: GPIO-driven RTS on TI hardware with 8250_omap driver
In-Reply-To: <CAJs94EZ6ooNvD5bf0NrjcRci+WS_f3Utf1wkboF_twCZt=8m7A@mail.gmail.com>
References: <CAEo2pzugEO+jnwdWrRqKR3y4Gzveh9MMaZmRrksfgYzMf6WpPA@mail.gmail.com>
 <CAHp75Vd6eTXnwErTZdug_rW51mk2sZv5=nT2800ourp=VEHY=Q@mail.gmail.com>
 <CAJs94EZ6ooNvD5bf0NrjcRci+WS_f3Utf1wkboF_twCZt=8m7A@mail.gmail.com>
Message-ID: <CAEo2pzvg3W9zVyxKMAH0QwfSZLufc76o=DiN5QT0hqcm8cCAFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matwey,

2015-12-27 16:14 GMT+03:00 Matwey V. Kornilov <matwey@sai.msu.ru>:
> The half of what is described here are implemented in my patches.
> But I cannot understand the other half. Each of six AM335x UARTs has
> RTS/CTS pins which are controlled by pinmux in device tree, no magic
> required here.

The problem here is, the appliance schematics are already designed in
such way that pins which can be configured as "native" RTS are not
used for RS485 control - the ones that are though may only be used as
GPIO flipped by software on transmission start/end for that purpose.
We simply cannot change the schematics on production because of this
issue alone.

Regards,
Ilyas G.
