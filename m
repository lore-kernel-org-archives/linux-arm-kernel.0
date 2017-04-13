From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 13 Apr 2017 12:03:41 -0700
Subject: [PATCH 4/8] ARM: dts: imx7s: Add node for GPC
In-Reply-To: <20170413133242.5068-5-andrew.smirnov@gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-5-andrew.smirnov@gmail.com>
Message-ID: <CANMBJr5sFeVxVq2w2uUd-ehXi9SpaJ7W9S_PTS_VN25YZEdXvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On 13 April 2017 at 06:32, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Add node for GPC and specify as a parent interrupt controller for SoC bus.
>
> Cc: yurovsky at gmail.com
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/imx7s.dtsi | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 8fee299..1a7058f 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -42,6 +42,7 @@
>   */
>[0
>  #include <dt-bindings/clock/imx7d-clock.h>
> +#include <dt-bindings/power/imx7-power.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -119,7 +120,7 @@
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 compatible = "simple-bus";
> -               interrupt-parent = <&intc>;
> +               interrupt-parent = <&gpc>;

I've been testing your GPC/PCIe patch sets against v4.11-rc5 on my
imx7d-cl-som-imx7, but hit a bit of a wall. When gpc is set as the
interrupt-parent for the soc, the kernel seems to hang and not produce
any output on the serial port[0]. I tried to enable earlyprintk, but
no luck getting a trace. Reversing this change, gets the board
booting[1], but obviously isn't using the gpc which is needed for PCIe
support as I understand it. I assume you've tested these changes on a
imx7d-sdb and are not seeing a similar issue? You can find the patches
I've picked on top of v4.11-rc5 here[2], any idea what might be the
issue?

Cheers,

Tyler

[0] https://hastebin.com/zetohetuwi.coffeescript
[1] https://hastebin.com/uvacuyicuh.sql
[2] https://github.com/EmbeddedAndroid/linux/commits/tracking-ltd-imx-dev
