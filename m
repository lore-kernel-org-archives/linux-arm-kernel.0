From: brendanhiggins@google.com (Brendan Higgins)
Date: Thu, 28 Sep 2017 11:35:33 -0700
Subject: [PATCH 3/8] ARM: dts: aspeed: Add I2C buses
In-Reply-To: <20170928075149.8154-4-joel@jms.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-4-joel@jms.id.au>
Message-ID: <CAFd5g46LrdCkPq-dZyrA3Nnw28=r-sCsPvp5bWngYUF=3RmDYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 12:51 AM, Joel Stanley <joel@jms.id.au> wrote:
> Now with an upstream i2c bus driver, we can add  the 14 i2c buses that
> exist in ASPEED G4 and G5 generation SoCs.
>
> It also adds aliases for the 14 built-in I2C busses to ensure userspace
> sees the numbering staring from zero and counting up.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

nit: can we make the i2c labels and the pinctrl labels match?

For example:

> +
> +       i2c13: i2c-bus at 480 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               #interrupt-cells = <1>;
> +
> +               reg = <0x480 0x40>;
> +               compatible = "aspeed,ast2500-i2c-bus";
> +               clocks = <&clk_apb>;
> +               bus-frequency = <100000>;
> +               interrupts = <13>;
> +               interrupt-parent = <&i2c_ic>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_i2c14_default>;
> +               status = "disabled";
> +       };

"i2c13" has a pinctrl-0 of "pinctrl_i2c14_default"

I know that pinctrl_i2c14_default is consistent with the function and
groups it uses, but I would like to see them all be consistent at some
point in the future.
