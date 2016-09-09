From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Sep 2016 18:59:56 -0300
Subject: [PATCH v3 2/3] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 initial support
In-Reply-To: <1473457525-27768-2-git-send-email-jagan@amarulasolutions.com>
References: <1473457525-27768-1-git-send-email-jagan@amarulasolutions.com>
 <1473457525-27768-2-git-send-email-jagan@amarulasolutions.com>
Message-ID: <CAOMZO5BPhY14S4G541MTpsCW64SsCiNcsksJarBCWqGOnaPf3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2016 at 6:45 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:

> +&iomuxc {
> +       pinctrl_flexcan1: flexcan1grp {
> +               fsl,pins = <
> +                       MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0x1b020
> +                       MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0x1b020

In the previous version you had "0x80000000", which means: use the pad
value that comes from the bootloader.

Does your bootloader configure the CAN pins? If not, then it should be
1b0b0, which is the POR value of register
IOMUXC_SW_PAD_CTL_PAD_KEY_ROW2.

To confirm, you can do this in your bootloader:

=> md.l 20E05DC 1
020e05dc: 0001b0b0

and see if returns 1b0b0 or 1b020.
