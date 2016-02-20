From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 20 Feb 2016 12:02:51 -0200
Subject: [PATCH 1/4] ARM: dts: imx6ul: Add flexcan1 and flexcan2 support
In-Reply-To: <1455963652-24618-2-git-send-email-michael@amarulasolutions.com>
References: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
 <1455963652-24618-2-git-send-email-michael@amarulasolutions.com>
Message-ID: <CAOMZO5Bk_ZMhYzFLRFNK2TQvK4KHuj62AM_6uF-m-P1kJupTHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 20, 2016 at 8:20 AM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:

> +
> +                               flexcan1: can at 02090000 {
> +                                       compatible = "fsl,imx6ul-flexcan", "fsl,imx6q-flexcan";
> +                                       reg = <0x02090000 0x4000>;
> +                                       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +                                       clocks = <&clks IMX6UL_CLK_CAN1_IPG>,
> +                                                <&clks IMX6UL_CLK_CAN1_SERIAL>;
> +                                       clock-names = "ipg", "per";
> +                                       stop-mode = <&gpr 0x10 1 0x10 17>;

This 'stop-mode' property is not handled in mainline, only in NXP
kernel, so I suggest to drop this.
