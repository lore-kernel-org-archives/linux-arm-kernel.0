From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2016 16:37:30 +0200
Subject: [PATCH 3/8] gpio: stmpe: fix edge and rising/falling edge
 detection
In-Reply-To: <1461068317-28016-4-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
 <1461068317-28016-4-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdZWmYo-QgVgYaoHwUV7t=e5MGi-Ge5oWjKAi46+h1JMWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 2:18 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> By cross-checking STMPE 610/801/811/1601/2401/2403 datasheets,
> it appears that edge detection and rising/falling edge detection
> is not supported by all STMPE variant:
>
>            GPIO              GPIO
>       Edge detection     rising/falling
>                          edge detection
>  610 |      X        |         X       |
>  801 |               |                 |
>  811 |      X        |         X       |
> 1600 |               |                 |
> 1601 |      X        |         X       |
> 1801 |               |         X       |
> 2401 |      X        |         X       |
> 2403 |      X        |         X       |
>
> Rework stmpe_dbg_show_one() and stmpe_gpio_irq to correctly
> take these cases into account.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Very nice.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I expect this to go into the MFD tree with the rest, I guess
Lee will cook me an immutable branch for the whole thing
once he's happy with it.

Yours,
Linus Walleij
