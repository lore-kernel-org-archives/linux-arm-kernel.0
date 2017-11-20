From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 20 Nov 2017 21:37:04 -0200
Subject: [PATCH 2/2] ARM: dts: TS-7970: add basic device tree
In-Reply-To: <20171120211557.27946-2-sebastien.bourdelin@savoirfairelinux.com>
References: <20171120211557.27946-1-sebastien.bourdelin@savoirfairelinux.com>
 <20171120211557.27946-2-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <CAOMZO5AFEqk6FcfzJGO6VH0LpF7uFnkmiMYds9y=jajx8ygdZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastien,

On Mon, Nov 20, 2017 at 7:15 PM, Sebastien Bourdelin
<sebastien.bourdelin@savoirfairelinux.com> wrote:

> +&ecspi2 {
> +       cs-gpios = <
> +               &gpio5 31 GPIO_ACTIVE_HIGH
> +               &gpio7 12 GPIO_ACTIVE_HIGH
> +               &gpio5 18 GPIO_ACTIVE_HIGH
> +       >;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi2>;
> +       status = "okay";
> +
> +       spidevfpga: spi at 1 {
> +               compatible = "spidev";
> +               reg = <1>;
> +               spi-max-frequency = <1000000>;

According to drivers/spi/spidev.c:

/*
* spidev should never be referenced in DT without a specific
* compatible string, it is a Linux implementation thing
* rather than a description of the hardware.
*/
