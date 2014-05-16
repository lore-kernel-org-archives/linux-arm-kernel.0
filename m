From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 May 2014 15:35:48 +0200
Subject: [PATCH v3 6/7] Documentation: add the Marvell Berlin pinctrl
 documentation
In-Reply-To: <1399267649-20218-7-git-send-email-antoine.tenart@free-electrons.com>
References: <1399267649-20218-1-git-send-email-antoine.tenart@free-electrons.com>
 <1399267649-20218-7-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CACRpkdaL9tzfUrY=wLjSR3dcD7JC1mUX3kdG+Wh5gDyxGY2Yqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 5, 2014 at 7:27 AM, Antoine T?nart
<antoine.tenart@free-electrons.com> wrote:

> Add the documentation related to the Berlin pin-controller driver and
> explain how to configure this group based controller.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
(...)

When I see this:

> +Required subnode-properties:
> +- marvell,groups: a list of strings describing the group names.
> +- marvell,function: a string describing the function used to mux the groups.
> +
> +Example:
> +
> +sm_pinctrl: pin-controller at 0 {
> +       compatible = "marvell,berlin2q-sysmgr-pinctrl";
> +       reg = <0xfc0000 0x44>;
> +
> +       uart0_pmux: uart0-pmux {
> +               marvell,groups = "GSM12", "GSM13";
> +               marvell,function = "uart0";
> +       };
> +}

I feel like ... can't we just standardize that and make it a common
pinctrl binding, and name the properties "groups" and "function"
for a family of pin controllers just mapping N groups to 1 function?

I will merge the patches as are, but maybe we can make it generic
on top of this before the merge window?

Yours,
Linus Walleij
