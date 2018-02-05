From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:09:19 -0600
Subject: [PATCH v2 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <20180201183126.32384-2-l.stach@pengutronix.de>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-2-l.stach@pengutronix.de>
Message-ID: <20180205060919.g7slfswr25od3pja@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 07:31:24PM +0100, Lucas Stach wrote:
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
> v2:
>  - move to freescale folder
>  - change compatibles to "fsl" vendor prefix
>  - remove unnecessary newlines
>  - move status property to be the last in all node
>  - remove imx21 compatibles from UART nodes
>  - document compatible
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt  |   4 +
>  arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h | 623 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi      | 411 ++++++++++++++++
>  3 files changed, 1038 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq.dtsi

Reviewed-by: Rob Herring <robh@kernel.org>
