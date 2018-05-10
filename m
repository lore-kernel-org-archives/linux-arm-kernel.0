From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 May 2018 22:45:39 -0300
Subject: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
In-Reply-To: <20180509153428.1440-1-lukma@denx.de>
References: <20180509153428.1440-1-lukma@denx.de>
Message-ID: <CAOMZO5BGfoLZDesBN=hQ5cr7Rkm1p6xyggwTvWNq6QKJZVyzeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2018 at 12:34 PM, Lukasz Majewski <lukma@denx.de> wrote:

> +               button at 1 {
> +                       label = "Kaltstart";
> +                       linux,code = <64>; /* KEY_F6 */

If you include <dt-bindings/input/input.h> then you can simply do:

 linux,code = <KEY_F6 >;

> +                       gpios = <&gpio2 26 GPIO_ACTIVE_HIGH>;
> +               };
> +               button at 2 {
> +                       label = "PowerFailInterrupt";
> +                       linux,code = <65>; /* KEY_F7 */

Same here.
