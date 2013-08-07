From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Aug 2013 20:31:32 +0200
Subject: [PATCH v2] pinctrl: imx: work around select input quirk
In-Reply-To: <1375623563-23706-1-git-send-email-shawn.guo@linaro.org>
References: <1375623563-23706-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdZ+eEwBL_VwnG4FH0ENSEFD+8hPb0mgPygvdSZSdLMMkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 4, 2013 at 3:39 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The select input for some pin may not be implemented using the regular
> select input register but the general purpose register.  A real example
> is that imx6q designers found the select input for USB OTG ID pin is
> missing at the very late stage, and can not add a new select input
> register but have to use a general purpose register bit to implement it.
>
> The patch adds a workaround for such select input quirk by interpreting
> the input_val cell of pin function ID in a different way, so that all
> the info that needed for setting up select input bits in general purpose
> register could be decoded from there.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Tested-by: Peter Chen <peter.chen@freescale.com>
> ---
> Changes since v1:
>  * For quirky select input where IOMUXC general purpose register is
>    used, the register could be possibly at offset 0.  Cover this case
>    in v2.

Patch applied.

Yours,
Linus Walleij
