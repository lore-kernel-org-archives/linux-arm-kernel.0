From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Aug 2017 15:55:55 +0200
Subject: [PATCH 3/8] gpio: zynq: Shift zynq_gpio_init() to subsys_initcall
 level
In-Reply-To: <a05cc4f104097bef71ed381229aa8c746717ebce.1502103715.git.michal.simek@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
 <a05cc4f104097bef71ed381229aa8c746717ebce.1502103715.git.michal.simek@xilinx.com>
Message-ID: <CACRpkdbUBe6z2C9U9THaaLq0JLuu=EsGAVQfaSY55tMUotKvvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 7, 2017 at 1:01 PM, Michal Simek <michal.simek@xilinx.com> wrote:

> From: Nava kishore Manne <nava.manne@xilinx.com>
>
> In general situation on-SoC GPIO controller drivers should be probed
> after pinctrl/pinmux controller driver, because on-SoC GPIOs utilize a
> pin/pad as a resource provided and controlled by pinctrl subsystem.
>
>   GPIO must come after pinctrl as gpios may need to mux pins....etc
>
> Looking at Xilinx SoC series pinctrl drivers, zynq*_pinctrl_init()
> functions are called at arch_initcall init levels,
> so the change of initcall level for gpio-zynq driver from
> postcore_initcall to subsys_initcall level is sufficient. Also note
> that the most of GPIO controller drivers settled at subsys_initcall
> level.
>
> If pinctrl subsystem manages pads with GPIO functions, the change is
> needed to avoid unwanted driver probe deferrals during kernel boot.
>
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Can't you just move it all the way to device_initcall and
simply use the standard module init macros?
builtin_platform_driver(), module_platform_driver()?

Yours,
Linus Walleij
