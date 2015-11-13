From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 13 Nov 2015 10:02:52 -0600
Subject: [PATCH v8 1/4] Documentation: dt-bindings: Describe SROMc
 configuration
In-Reply-To: <e9e18ab5aa7a147aaa63d1900ad52174413e86d9.1447333689.git.p.fedin@samsung.com>
References: <cover.1447333689.git.p.fedin@samsung.com>
 <e9e18ab5aa7a147aaa63d1900ad52174413e86d9.1447333689.git.p.fedin@samsung.com>
Message-ID: <CAL_JsqLfzGjNwH=kqwcZXvPRSc_m1NgxhFcenu6L1Efva+k9Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 7:12 AM, Pavel Fedin <p.fedin@samsung.com> wrote:
> Add documentation for new subnode properties, allowing bank configuration.
> Based on u-boot implementation, but heavily reworked.
>
> Also, fix size of SROMc mapping in the example.
>
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Acked-by: Rob Herring <robh@kernel.org>

One nit below.

>                 compatible = "samsung,exynos-srom";
> -               reg = <0x12570000 0x10>;
> +               reg = <0x12570000 0x14>;
> +
> +               ethernet at 3 {

This should actually be "ethernet at 3,0"

Fields (not cells) in the unit address should be separated by commas.

> +                       compatible = "smsc,lan9115";
> +                       reg = <3 0 0x10000>;       // Bank 3, offset = 0
> +                       phy-mode = "mii";
> +                       interrupt-parent = <&gpx0>;
> +                       interrupts = <5 8>;
> +                       reg-io-width = <2>;
> +                       smsc,irq-push-pull;
> +                       smsc,force-internal-phy;
> +
> +                       samsung,srom-page-mode = <1>;
> +                       samsung,srom-timing = <9 12 1 9 1 1>;
> +               };
>         };
> --
> 2.4.4
>
