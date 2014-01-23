From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Jan 2014 08:33:48 +0100
Subject: [PATCH v2 4/4] ARM:STi: STiH415: Add interrupt support for pin
 controller
In-Reply-To: <1389886665-32076-1-git-send-email-srinivas.kandagatla@st.com>
References: <1389886545-31498-1-git-send-email-srinivas.kandagatla@st.com>
 <1389886665-32076-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <CACRpkdZhUshDzSQtTO=ZXk1Lany1C-2UBBjVTwykh8DSLpFBAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 4:37 PM,  <srinivas.kandagatla@st.com> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>
> This patch adds interrupt support for STiH415 pin controllers.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Merge this through ARM SoC.

> +                       reg             = <0xfe61f080 0x4>;
> +                       reg-names       = "irqmux";

Aha so that is how it looks when you handle the separate
mux reg, well I can't think of anything better and this works
fine for me.

The alternative would be to have a syscon thing using regmap
such as drivers/mfd/syscon.c but I really cannot decide
between these two design patterns for odd registers.

Yours,
Linus Walleij
