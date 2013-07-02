From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 2 Jul 2013 08:45:56 -0300
Subject: [PATCHv3 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
In-Reply-To: <51D2BB05.9040201@free-electrons.com>
References: <1372094699-3832-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372094699-3832-3-git-send-email-alexandre.belloni@free-electrons.com>
 <CAOMZO5CLcT=OXYd=ggxpDzUqFxoXSaanqUPGugYLT2Og-VgzCA@mail.gmail.com>
 <51D2BB05.9040201@free-electrons.com>
Message-ID: <CAOMZO5DZufiOjguOCEbe5n0j=w9B5ezBYh0Rejv3zF5Xht5_qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 2, 2013 at 8:35 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> mxs-i2c 8005a000.i2c: Failed to get PIO reg. write descriptor.
>
> That is the one line 243. I'm open to any suggestion.
>
> BTW, I also tested PIO mode with and without touchscreen support as that
> seemed to toggle the issue on your side. It is also worse than what it
> was in 3.9. Trying to read the nau7802 ADC never returns.
>
> The excerpt from my DT:
>
> i2c1: i2c at 8005a000 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2c1_pins_a>;
>         status = "okay";
> };
>
> i2cmux {
>         compatible = "i2c-mux-gpio";
>         #address-cells = <1>;
>         #size-cells = <0>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2cmux_pins_cfa10049>;
>         mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
>         i2c-parent = <&i2c1>;
>
>         i2c at 0 {
>                 reg = <0>;

Shouldn't this be

         i2c at 1 {
                 reg = <1>; ?
