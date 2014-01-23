From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Jan 2014 08:22:53 +0100
Subject: [PATCH v2 1/4] pinctrl: st: Add Interrupt support.
In-Reply-To: <1389886613-31945-1-git-send-email-srinivas.kandagatla@st.com>
References: <1389886545-31498-1-git-send-email-srinivas.kandagatla@st.com>
 <1389886613-31945-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <CACRpkdZV7TBP7Ac1MPVSAgJeqWtDQEuT3dHjUJHgDTeX9_datw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 4:36 PM,  <srinivas.kandagatla@st.com> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>
> This patch add interrupt support to the pincontroller driver.
>
> ST Pincontroller GPIO bank can have one of the two possible types of
> interrupt-wirings.
>
> First type is via irqmux, single interrupt is used by multiple gpio
> banks. This reduces number of overall interrupts numbers required. All
> these banks belong to a single pincontroller.
>                   _________
>                  |         |----> [gpio-bank (n)    ]
>                  |         |----> [gpio-bank (n + 1)]
>         [irqN]-- | irq-mux |----> [gpio-bank (n + 2)]
>                  |         |----> [gpio-bank (...  )]
>                  |_________|----> [gpio-bank (n + 7)]
>
> Second type has a dedicated interrupt per gpio bank.
>
>         [irqN]----> [gpio-bank (n)]
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

I've applied this patch so that it won't just sit idle.
Besides you've done a real good job on it Srinivas.

It'll be for v3.15 though and I'm still waiting to see if
the device tree people say something about it.

Yours,
Linus Walleij
