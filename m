From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jul 2014 16:59:19 +0200
Subject: [PATCH] pinctrl: st: Fix irqmux handler
In-Reply-To: <1403264094-16140-1-git-send-email-maxime.coquelin@st.com>
References: <1403264094-16140-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <CACRpkdbB5zniNTdUSgMmmqFQwGjHLAF9p601R5A_DkNdz0q01w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 1:34 PM, Maxime COQUELIN <maxime.coquelin@st.com> wrote:

> st_gpio_irqmux_handler() reads the status register to find out
> which banks inside the controller have pending IRQs.
> For each banks having pending IRQs, it calls the corresponding handler.
>
> Problem is that current code restricts the number of possible banks inside the
> controller to ST_GPIO_PINS_PER_BANK. This define represents the number of pins
> inside a bank, so it shouldn't be used here.
>
> On STiH407, PIO_FRONT0 controller has 10 banks, so IRQs pending in the two
> last banks (PIO18 & PIO19) aren't handled.
>
> This patch replace ST_GPIO_PINS_PER_BANK by the number of banks inside the
> controller.
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: <stable@vger.kernel.org> #v3.15+
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>

Patch applied for fixes with Srinivas ACK.

Thanks!
Yours,
Linus Walleij
