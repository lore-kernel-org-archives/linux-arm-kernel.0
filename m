From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 24 Jan 2017 18:43:21 -0800
Subject: [PATCH v5 3/3] watchdog: zx2967: add watchdog controller driver
 for ZTE's zx2967 family
In-Reply-To: <CA+DQWky4---=gRipAR=NqajvwYV2QQQWbztTpPJS5oaL4D6QaQ@mail.gmail.com>
References: <1485248322-24299-1-git-send-email-baoyou.xie@linaro.org>
 <1485248322-24299-3-git-send-email-baoyou.xie@linaro.org>
 <35dcd00f-a4bd-a313-0d6f-932a3f5888f0@roeck-us.net>
 <CA+DQWky4---=gRipAR=NqajvwYV2QQQWbztTpPJS5oaL4D6QaQ@mail.gmail.com>
Message-ID: <74bfcbb3-a9ce-8228-77d3-db4defa79df5@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2017 06:16 PM, Baoyou Xie wrote:
>
[ ... ]
>         +
>         +       ret = of_parse_phandle_with_fixed_args(dev->of_node,
>         +                       "zte,wdt-reset-sysctrl", 3, 0, &out_args);
>         +       if (ret)
>         +               return;
>         +
>         +       offset = out_args.args[0];
>         +       config = out_args.args[1];
>         +       mask = out_args.args[2];
>         +
>         +       regmap = syscon_node_to_regmap(out_args.np <http://out_args.np>);
>         +       if (IS_ERR(regmap))
>         +               return;
>         +
>         +       regmap_update_bits(regmap, offset, mask, config);
>
>
>     Another comment suggested adding
>             of_node_put(out_args.np <http://out_args.np>);
>     here.
>
>
> is it really? most of the driver that call this function don't call of_node_put. but it seems harmless to call of_node_put.
>
>
Even if everyone else is doing things wrong, that doesn't mean
that you should do the same, nor is it a good idea to use it
as argument.

Guenter
