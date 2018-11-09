From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Nov 2018 10:26:06 +0100
Subject: [PATCH v2] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
In-Reply-To: <20181107085639.32366-1-natechancellor@gmail.com>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <20181107085639.32366-1-natechancellor@gmail.com>
Message-ID: <CACRpkdZ1424qqPbYrP+vE6WTA81nHb=5Pi7vxD7cgJ9vOonj9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 9:57 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Clang warns when one enumerated type is implicitly converted to another:
>
> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
> enumeration type 'enum zynq_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
>         ~               ^~~~~~~~~~~~~~~~~~~~~
> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
> enumeration type 'enum zynq_pin_config_param' to different enumeration
> type 'enum pin_config_param' [-Wenum-conversion]
>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> macro 'PCONFDUMP'
>         .param = a, .display = b, .format = c, .has_arg = d     \
>                  ^
> 2 warnings generated.
>
> It is expected that pinctrl drivers can extend pin_config_param because
> of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> isn't an issue. Most drivers that take advantage of this define the
> PIN_CONFIG variables as constants, rather than enumerated values. Do the
> same thing here so that Clang no longer warns.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:

This v2 version applied with Michal's ACK.

Yours,
Linus Walleij
