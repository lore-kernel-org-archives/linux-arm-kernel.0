From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 May 2018 10:07:02 +0200
Subject: [PATCH v5 4/4] gpiolib: discourage gpiochip_add_pin[group]_range
 for DT pinctrls
In-Reply-To: <2969992a1005d7e7f4ea23d4c684d2f10d4a0aca.1526935804.git.chunkeey@gmail.com>
References: <270904bcbf03a6b6ac3150f4a7daa15aa7e97586.1526935804.git.chunkeey@gmail.com>
 <0ae3376606a89bcdf3fe753a5c967f7103699e09.1526935804.git.chunkeey@gmail.com>
 <910e5a85a6a8020069996e2ff397c93e9c5fe18c.1526935804.git.chunkeey@gmail.com>
 <2969992a1005d7e7f4ea23d4c684d2f10d4a0aca.1526935804.git.chunkeey@gmail.com>
Message-ID: <CACRpkdbOTfoj293LO-nyPEbxwXOWRuNyTqwxb_MWoQ2wM3=-Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 10:57 PM, Christian Lamparter
<chunkeey@gmail.com> wrote:

> This patch adds the stern warning to the kerneldoc text of both
> gpiochip_add_pin[group]_range() functions in hope of detering
> developers from ever using them in their DeviceTree-supported
> pinctrl drivers in the future.
>
> For anyone affected: Please refer to Section 2.1 of
> Documentation/devicetree/bindings/gpio/gpio.txt on how to
> bind pinctrl and gpio drivers via the "gpio-ranges" property.
>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

I'm a big fan of this patch, so applied.

I wouldn't mind a pr_info() warning about it at runtime too,
but this is nice.

Yours,
Linus Walleij
