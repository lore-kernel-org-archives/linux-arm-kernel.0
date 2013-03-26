From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Tue, 26 Mar 2013 16:12:35 +0100
Subject: [PATCH 1/2] clk: mxs: get base address from device tree
In-Reply-To: <1364306374-10481-2-git-send-email-shawn.guo@linaro.org>
References: <1364306374-10481-1-git-send-email-shawn.guo@linaro.org>
 <1364306374-10481-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAHXqBFK+VHTDHNcTcsmYkxtMPE-qxsZAO5w02YVkXnraWHGo3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/26 Shawn Guo <shawn.guo@linaro.org>:
> Instead of using the static definitions, get clkctrl and digctl base
> addresses with mapping from device tree.
>
> Use macro on variable is not nice, but it's done here to save huge
> pointless diff stat.
>
[...]
> @@ -100,6 +105,14 @@ int __init mx23_clocks_init(void)
>         struct device_node *np;
>         u32 i;
>
> +       np = of_find_compatible_node(NULL, NULL, "fsl,imx23-digctl");
> +       digctrl = of_iomap(np, 0);
> +       WARN_ON(!digctrl);
> +
> +       np = of_find_compatible_node(NULL, NULL, "fsl,imx23-clkctrl");
> +       clkctrl = of_iomap(np, 0);
> +       WARN_ON(!clkctrl);
> +

WARN? Won't the system die soon anyway if the addresses cannot be found?

Best Regards,
Micha? Miros?aw
