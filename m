From: nicolas.dechesne@linaro.org (Nicolas Dechesne)
Date: Thu, 24 Mar 2016 17:51:01 +0100
Subject: [PATCH 10/12] ARM: dts: dragonboard-600c: Add on board leds
 support
In-Reply-To: <1458762484-9768-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762484-9768-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <CAP71WjzdDRqtS4oJu_m_Y9kuZ4QprYnqMHop=5a6Vc6yypakhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 8:48 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> +                       led at 1 {
> +                               label = "dragonboard-600c:green:user1";
> +                               gpios = <&tlmm_pinmux 3 GPIO_ACTIVE_HIGH>;
> +                               linux,default-trigger = "heartbeat";
> +                               default-state = "off";
> +                       };
> +
> +                       led at 2 {
> +                               label = "dragonboard-600c:green:user2";
> +                               gpios = <&tlmm_pinmux 7 GPIO_ACTIVE_HIGH>;
> +                               linux,default-trigger = "mmc0";
> +                               default-state = "off";
> +                       };
> +
> +                       led at 3 {
> +                               label = "dragonboard-600c:green:user3";
> +                               gpios = <&tlmm_pinmux 10 GPIO_ACTIVE_HIGH>;
> +                               linux,default-trigger = "mmc1";
> +                               default-state = "off";
> +                       };
> +
> +                       led at 4 {
> +                               label = "apq8016-sbc:green:user4";

typo ^^

> +                               gpios = <&tlmm_pinmux 11 GPIO_ACTIVE_HIGH>;
> +                               linux,default-trigger = "none";
> +                               default-state = "off";
> +                       };

also, if i read the 96boards specs correctly, the LED are labeled
3-2-1-0 , if you look at the board with the LEDs on the bottom. With
this DT config, you end up with 0-1-2-3 instead.

also, they should be labeled 0 to 3, not 1 to 4.
