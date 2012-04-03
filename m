From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 Apr 2012 23:18:47 +0200
Subject: [PATCH] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
References: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
Message-ID: <CACRpkdZr3cZ=foqfB_r5+2N=sa_ON4=UDjrqmr0acKsc50SHRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2012 at 1:40 PM, Viresh Kumar <viresh.kumar@st.com> wrote:

> ?drivers/pinctrl/spear/pinctrl-spear300.c ? ? ? ? ? | ?661 ++++
> ?drivers/pinctrl/spear/pinctrl-spear310.c ? ? ? ? ? | ?384 +++
> ?drivers/pinctrl/spear/pinctrl-spear320.c ? ? ? ? ? | 3421 ++++++++++++++++++++
> ?drivers/pinctrl/spear/pinctrl-spear3xx.c ? ? ? ? ? | ?626 ++++

A lot of data but as we've said, it's OK if you want to do it this way.

> +static struct of_device_id spear_pinctrl_of_match[] __devinitdata = {
> +#ifdef CONFIG_PINCTRL_SPEAR300
> + ? ? ? {
> + ? ? ? ? ? ? ? .compatible = "st,spear300-pinmux",
> + ? ? ? ? ? ? ? .data = spear300_mach_init,
> + ? ? ? },
> +#endif
> +#ifdef CONFIG_PINCTRL_SPEAR310
> + ? ? ? {
> + ? ? ? ? ? ? ? .compatible = "st,spear310-pinmux",
> + ? ? ? ? ? ? ? .data = spear310_mach_init,
> + ? ? ? },
> +#endif
> +#ifdef CONFIG_PINCTRL_SPEAR320
> + ? ? ? {
> + ? ? ? ? ? ? ? .compatible = "st,spear320-pinmux",
> + ? ? ? ? ? ? ? .data = spear320_mach_init,
> + ? ? ? },
> +#endif

Ugh this is not looking good, please check Arnds advice in how to restructure
this a bit... #ifdef is ugly (and error-prone).

Apart from this it looks pretty straight-forward. Make sure to rebase
onto your own patches in linux-next for next version.

Linus Walleij
