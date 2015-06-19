From: nicolae.rosia@gmail.com (Nicolae Rosia)
Date: Fri, 19 Jun 2015 20:05:22 +0300
Subject: [PATCH v2 6/8] ARM: dts: imx: add imx6ul and imx6ul evk board
 support
In-Reply-To: <1434727951-4852-7-git-send-email-Frank.Li@freescale.com>
References: <1434727951-4852-1-git-send-email-Frank.Li@freescale.com>
 <1434727951-4852-7-git-send-email-Frank.Li@freescale.com>
Message-ID: <CAH=tA9G_x=6wNTOWbOc2FGGARTxioikUSwqyENKk74wL=7uzaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 19, 2015 at 6:32 PM,  <Frank.Li@freescale.com> wrote:
> From: Frank Li <Frank.Li@freescale.com>
[...]
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu at 0 {
> +                       compatible = "arm,cortex-a7";
> +                       device_type = "cpu";
> +                       reg = <0>;
> +                       clock-latency = <61036>; /* two CLK32 periods */
> +                       operating-points = <
> +                               /* kHz  uV */
> +                               528000  1250000
> +                               396000  1150000
> +                               198000  1150000
> +                       >;
> +                       fsl,soc-operating-points = <
> +                               /* KHz  uV */
> +                               528000  1250000
> +                               396000  1150000
> +                               198000  1150000
> +                       >;
Why is this necessary? Can't you adapt the driver to use operating-points?
I have looked through other imx dts and saw that some had different
values in these two tables.

Best regards,
Nicolae Rosia
