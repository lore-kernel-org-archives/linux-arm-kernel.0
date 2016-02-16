From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Feb 2016 16:17:31 +0100
Subject: [PATCH v3 09/10] ARM: dts: introduce MPS2 AN385/AN386
In-Reply-To: <1455617295-23736-10-git-send-email-vladimir.murzin@arm.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <1455617295-23736-10-git-send-email-vladimir.murzin@arm.com>
Message-ID: <CACRpkdafDhT=1uJssVNAW+g05eXbRC1xUL+O0+SxcpdczUX0vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 11:08 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:

> Application Notes 385 and 386 shares the same memory map and features
> except the CPU is used. AN385 is supplied with Cortex-M3 CPU and AN386
> is supplied with Cortex-M4.
>
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
(...)
> +               fpgaio {
> +                       compatible = "syscon", "simple-mfd";
> +                       reg = <0x40028000 0x10>;
> +
> +                       led at 0 {
> +                               compatible = "register-bit-led";
> +                               offset = <0x0>;
> +                               mask = <0x01>;
> +                               label = "userled:0";
> +                               linux,default-trigger = "heartbeat";
> +                               default-state = "on";
> +                       };
> +
> +                       led at 1 {
> +                               compatible = "register-bit-led";
> +                               offset = <0x0>;
> +                               mask = <0x02>;
> +                               label = "userled:1";
> +                               linux,default-trigger = "usr";
> +                               default-state = "off";
> +                       };
> +               };

Thanks for using this. I worked hard to massage this into the
core.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
