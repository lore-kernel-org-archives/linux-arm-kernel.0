From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Jun 2018 10:35:30 +0200
Subject: [PATCH] pinctrl: actions: Fix uninitialized error in
 owl_pin_config_set()
In-Reply-To: <1528452347-23986-1-git-send-email-geert@linux-m68k.org>
References: <1528452347-23986-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CACRpkdbMogW3oVv0NEX1b622H8g4k-3MtzLONhog5TKsPn5qCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 8, 2018 at 12:05 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> With gcc 4.1.2:
>
>     drivers/pinctrl/actions/pinctrl-owl.c: In function ?owl_pin_config_set?:
>     drivers/pinctrl/actions/pinctrl-owl.c:336: warning: ?ret? may be used uninitialized in this function
>
> Indeed, if num_configs is zero, the uninitialized value will be returned
> as an error code.
>
> Fix this by preinitializing it to zero.
>
> Fixes: 2242ddfbf4d699b5 ("pinctrl: actions: Add Actions S900 pinctrl driver")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Patch applied with Manivannan's ACK.

Yours,
Linus Walleij
