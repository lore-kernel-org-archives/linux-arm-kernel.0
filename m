From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 22 Jan 2018 22:47:31 +0800
Subject: [PATCH 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <20180117183244.28303-2-l.stach@pengutronix.de>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-2-l.stach@pengutronix.de>
Message-ID: <20180122144729.GA27764@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 07:32:42PM +0100, Lucas Stach wrote:
> This adds the basic DTS for the i.MX8MQ.
> For now only the following peripherals are supported:
> - IOMUXC (pin controller)
> - CCM (clock controller)
> - GPIO
> - UART
> - uSDHC (SD/eMMC controller)
> - FEC (ethernet controller)
> - i2c
> 
> This is enough to get a very basic board support up and running.
> 
> One known limitation is that the driver for the GPC interrupt
> controller is still missing, rendering the CPU sleep states unusable
> as there is nothing waking them up anymore. This will be fixed in
> due course.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/boot/dts/Makefile             |   1 +
>  arch/arm64/boot/dts/nxp/imx8mq-pinfunc.h | 632 +++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/nxp/imx8mq.dtsi      | 418 ++++++++++++++++++++

So we will have the following two folders for SoCs from the same company.

 arch/arm64/boot/dts/nxp/
 arch/arm64/boot/dts/freescale/

I'm a bit uncomfortable with that.  @Arnd, do you have an opinion how we
should handle them?

Shawn
