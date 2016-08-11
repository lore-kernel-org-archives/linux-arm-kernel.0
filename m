From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2016 16:07:52 +0200
Subject: [PATCH 1/4] pinctrl: st: Use second parameter to gpio specifier
In-Reply-To: <1470834781-23232-2-git-send-email-patrice.chotard@st.com>
References: <1470834781-23232-1-git-send-email-patrice.chotard@st.com>
 <1470834781-23232-2-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdb9GHvb1Fxvjrg+Qb5K8z=Xqu0NkGL3Uovdh0tgrVmofg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 3:12 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> This patch allows to use the second parameter of gpio
> specifier, which is used to specify whether the gpio is
> active high or low.
>
> Simply remove specific of_xlate callback() and of_gpio_n_cells
> and use default one set by of_gpiochip_add() which allows
> to use second parameter gpio specifier.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Patch applied.

It seems this is one of those drivers that could also implement
.set_single_ended() and support native open drain.

Either it can do so by poking that pin config directly from the
gpiochip callback or by figuring out how to interface with the
pin config backend and do it genercially... I've been thinking a
bit about that.

Yours,
Linus Walleij
