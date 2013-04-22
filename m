From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 22 Apr 2013 22:57:29 +0800
Subject: [PATCH 3/3] pinctrl: add MVF pinctrl driver
In-Reply-To: <1365753432-14247-1-git-send-email-b35083@freescale.com>
References: <1365753432-14247-1-git-send-email-b35083@freescale.com>
Message-ID: <20130422145727.GA27475@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 03:57:12PM +0800, Jingchang Lu wrote:
> It adds Freescale Vybrid Family pin controller
> driver to I.MX IOMUXC common driver architecture.
> The only difference is the MUX and CONF register
> is the same on MVF platform, so the defined
> config value including the mux_mode int DTS.
> 
This make no sense.  We should patch pinctrl-imx driver to support MVF.

> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  .../bindings/pinctrl/fsl,mvf-pinctrl.txt           |  825 ++++++++
>  drivers/pinctrl/Kconfig                            |    8 +
>  drivers/pinctrl/Makefile                           |    1 +
>  drivers/pinctrl/pinctrl-mvf.c                      | 2042 ++++++++++++++++++++

We just removed those big arrays of imx_pin_reg from imx pinctrl soc
drivers.  Please do not bring it back for MVF.

Shawn
