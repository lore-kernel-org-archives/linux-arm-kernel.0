From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Mar 2015 02:30:54 +0100
Subject: [PATCH 1/2] pinctrl: bindings: pinctrl: Add support for TI's
 IODelay configuration
In-Reply-To: <54FF38F3.2030703@ti.com>
References: <1425427237-11511-1-git-send-email-nm@ti.com>
 <1425427237-11511-2-git-send-email-nm@ti.com>
 <CACRpkdaLEPzBywMnMrteboK7Q4su8PoB0wjnGvVpgUJ=2czVxQ@mail.gmail.com>
 <20150310153321.GO5264@atomide.com> <54FF28F5.4040707@ti.com>
 <20150310173115.GS5264@atomide.com> <54FF38F3.2030703@ti.com>
Message-ID: <CACRpkdZ1faucps07jaT9kOyviC+Sw6gPkbF=cAGCUj+DiaEgTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 7:33 PM, Nishanth Menon <nm@ti.com> wrote:
> On 03/10/2015 12:31 PM, Tony Lindgren wrote:

>> Yes except I'd make use of some kind of #pinctrl-cells here just like
>> interrupt controller has #interrupt-cells. Then you can have the values
>> seprate and the controller knows what to do with them based on the
>> compatible flag and #pinctrl-cells.
>
> Something like the following I suppose, where pinctrl-cells is optional?
>
> dra7_pmx_core: pinmux at 4a003400 {
>         compatible = "ti,dra7-padconf", "pinctrl-single";
>         reg = <0x4a003400 0x0464>;
>         #address-cells = <1>;
>         #size-cells = <0>;
>         #interrupt-cells = <1>;
>         interrupt-controller;
>         pinctrl-single,register-width = <32>;
>         pinctrl-single,function-mask = <0x3fffffff>;
> };
>
> dra7_iodelay_core: padconf at 4844a000 {
>         compatible = "ti,dra7-iodelay";
>         reg = <0x4844a000 0x0d1c>;
>         #address-cells = <1>;
>         #size-cells = <0>;
>         #pinctrl-cells = <2>;
> };
>
> Linus,
>
> I hope you are ok with the above?

Hm depends on where the documentation hits I guess?

Such a generic cell count property has to be to the generic
pinctrl-bindings.txt document if I read it right.

Overall I guess this will be acceptable but you really need to
reuse some more code between this driver and pinctrl-single.c
if I read it right.

Yours,
Linus Walleij
