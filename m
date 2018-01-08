From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 08 Jan 2018 09:42:54 +0100
Subject: [PATCH v2 3/5] ARM64: dts: meson-axg: uart: Add the pinctrl
 info description
In-Reply-To: <b2571e30-d543-9288-68cf-1af86bb5f4bc@amlogic.com>
References: <20180106001044.108163-1-yixun.lan@amlogic.com>
 <20180106001044.108163-4-yixun.lan@amlogic.com>
 <CAFBinCCuQ-NK747+GHDkhZty_UMMgzCYOYFcNTrRDJgU8OM=Gw@mail.gmail.com>
 <b2571e30-d543-9288-68cf-1af86bb5f4bc@amlogic.com>
Message-ID: <1515400974.5048.58.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-01-08 at 14:07 +0800, Yixun Lan wrote:
> > (the following question just came up while I was looking at this
> > patch, but I guess it's more a question towards the pinctrl driver)
> > the name of the function looks a bit "weird" since below you are also
> > using "uart_ao_b"
> 
> you right here, it's a question related to pinctrl subsystem.
> from my point of view, it's even weird from the hardware perspective:
>  that, the UART function of AO domain route the pin of EE domain..
> 
> > did you choose "uart_ao_b_gpioz" here because we cannot have the same
> > function name for the periphs and AO pinctrl or is there some other
> > reason?
> > 
> 
> Current there is a conflict in the code level which both two pinctrl
> tree (EE, AO) are using the same macro[1] to expand the definitions, so
> there would be conflict symbol if we name both as 'uart_ao_b'
> 
> I think your idea of having an uniform function 'uart_ao_b' for both
> pinctrl subsystem is actually possible/positive..
> 
> I will think about your suggestion and come up with a patch later,
> thanks a lot!
> 
> 
> [1] drivers/pinctrl/meson/pinctrl-meson.h
> 
> #define FUNCTION(fn)                                                    \
>         {                                                               \
>                 .name = #fn,                                            \
>                 .groups = fn ## _groups,                                \
>                 .num_groups = ARRAY_SIZE(fn ## _groups),                \
>         }

The name feels weird because it should have been uart_ao_b_z ... We missed it in
the initial review. Except for correcting the function name, I don't think this
justify a change a pinctrl
