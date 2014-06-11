From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jun 2014 16:04:14 +0200
Subject: [PATCH v1] of/irq: do irq resolution in platform_get_irq_byname()
In-Reply-To: <CAGb2v64f8Wju6dtVuVN2x=9YVGA-=RXozzhpJZNspKZ05f=jtA@mail.gmail.com>
References: <1400582523-22684-1-git-send-email-grygorii.strashko@ti.com>
 <20140523080333.66720C4176E@trevor.secretlab.ca>
 <CAGa+x85mOHtNAj-UHgK2_z8zWAF=qwFcRcUgHTR-byNiX7heHA@mail.gmail.com>
 <CAL_JsqLm3wfVS+au+JUbhBhxz=LuVpepH6GxabCQhPowhbw77g@mail.gmail.com>
 <20140528071855.GJ4227@lee--X1>
 <CACRpkdYgkEOjLamYu5uKSgs3iTNJ-w5XkbeygKjRdR-bNdETfg@mail.gmail.com>
 <CAGb2v64f8Wju6dtVuVN2x=9YVGA-=RXozzhpJZNspKZ05f=jtA@mail.gmail.com>
Message-ID: <CACRpkdadSYFG-KaVYmUnf+gKzFKgEQBhABK7RWVgUv=sX-Up-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 10:49 AM, Chen-Yu Tsai <wens@csie.org> wrote:

> Log says musb is wrestling control over some pins with some other driver:
>
> [    1.441497] pinctrl-nomadik soc:pinctrl: pin GPIO256_AF28 already
> requested by a03e0000.usb_per5; cannot claim for musb-hdrc.0.auto
> [    1.453369] pinctrl-nomadik soc:pinctrl: pin-256 (musb-hdrc.0.auto)
> status -22
> [    1.460571] pinctrl-nomadik soc:pinctrl: could not request pin 256
> (GPIO256_AF28) from group usb_a_1  on device pinctrl-nomadik
> [    1.472076] musb-hdrc musb-hdrc.0.auto: Error applying setting,
> reverse things back
> [    1.479827] HS USB OTG: no transceiver configured
> [    1.484558] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed
> with status -517
> [    1.492309] platform musb-hdrc.0.auto: Driver musb-hdrc requests
> probe deferral
> [    1.500183] pinctrl-nomadik soc:pinctrl: pin GPIO256_AF28 already
> requested by a03e0000.usb_per5; cannot claim for musb-hdrc.0.auto
> [    1.512023] pinctrl-nomadik soc:pinctrl: pin-256 (musb-hdrc.0.auto)
> status -22
> [    1.519226] pinctrl-nomadik soc:pinctrl: could not request pin 256
> (GPIO256_AF28) from group usb_a_1  on device pinctrl-nomadik
> [    1.530731] musb-ux500 musb-hdrc.0.auto: Error applying setting,
> reverse things back
> [    1.539184] pinctrl-nomadik soc:pinctrl: pin GPIO256_AF28 already
> requested by a03e0000.usb_per5; cannot claim for musb-hdrc.1.auto
> [    1.551025] pinctrl-nomadik soc:pinctrl: pin-256 (musb-hdrc.1.auto)
> status -22
> [    1.558258] pinctrl-nomadik soc:pinctrl: could not request pin 256
> (GPIO256_AF28) from group usb_a_1  on device pinctrl-nomadik
> [    1.569732] musb-hdrc musb-hdrc.1.auto: Error applying setting,
> reverse things back
> [    1.577453] HS USB OTG: no transceiver configured
>
> [ .. repeats until the end .. ]
>
> I think this is not related to this patch.

No that is fixed i this patch:
http://marc.info/?l=linux-usb&m=140239049219096&w=2

Yours,
Linus Walleij
