From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Nov 2013 20:07:11 +0100
Subject: [PATCH v3 14/36] mtd: st_spi_fsm: Add device-tree binding
 documentation
In-Reply-To: <1385727565-25794-15-git-send-email-lee.jones@linaro.org>
References: <1385727565-25794-1-git-send-email-lee.jones@linaro.org>
 <1385727565-25794-15-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaWXBchz78Yby11VpveBDtn6FrmupS=cnNYhvHgFJsBUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 1:19 PM, Lee Jones <lee.jones@linaro.org> wrote:

Re this:

> +Optional properties:
> +  - st,syscfg          : Phandle to boot-device system configuration registers
> +  - st,boot-device-reg : Address of the aforementioned boot-device register(s)
> +  - st,boot-device-spi : Expected boot-device value if booted via this device
> +
> +Example:
> +       spifsm: spifsm at fe902000{
> +               compatible         = "st,spi-fsm";
> +               reg                =  <0xfe902000 0x1000>;
> +               reg-names          = "spi-fsm";
> +               pinctrl-0          = <&pinctrl_fsm>;
> +               st,syscfg          = <&syscfg_rear>;
> +               st,boot-device-reg = <0x958>;
> +               st,boot-device-spi = <0x1a>;

I don't think we should encode any register offsets whatsoever in device
tree but maybe that's just me. (Yes, Stephen will beat me up about
pin control single, but I consider that a special case.)

I would just put the last two things as #defines into the driver file(s)
or - if it's related to other syscfg registers and varies with SoC incarnation,
as a #define in a shared header for that syscfg thing.

The syscfg phandle is elegant though, really like that.

Yours,
Linus Walleij
