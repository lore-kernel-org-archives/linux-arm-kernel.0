From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 20 Aug 2015 01:29:40 +0200
Subject: [PATCH v2 1/3] ARM: dts: rockchip: add veyron-jaq board
In-Reply-To: <1440022721-73712-1-git-send-email-briannorris@chromium.org>
References: <1440022721-73712-1-git-send-email-briannorris@chromium.org>
Message-ID: <CABxcv=nQAfCzj_bQ9N-XYEPCNuihyrkUOz7=ogetKzye4KKNng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Brian,

[...]

> +
> +&rk808 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
> +       dvs-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>,
> +                   <&gpio7 15 GPIO_ACTIVE_HIGH>;

I see the dvs-gpios DT property is documented in the downstream
ChromiumOS 3.18 tree [0] but I don't see it neither mentioned in
Documentation/devicetree/bindings/mfd/rk808.txt in mainline nor code
that parses it in the drivers/regulator/rk808-regulator.c driver.

So I think this should be removed and also the dvs_{1,2} pinctrl
lines. The rest of the patch looks good to me though so with these
removed feel free to add:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

[0]: https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/Documentation/devicetree/bindings/mfd/rk808.txt

Best regards,
Javier
