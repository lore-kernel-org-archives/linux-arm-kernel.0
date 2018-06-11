From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Jun 2018 16:24:13 +0800
Subject: [PATCH v7 2/2] ARM: dts: imx: Add basic dts support for imx6sll
 EVK board
In-Reply-To: <1527234127-11991-2-git-send-email-ping.bai@nxp.com>
References: <1527234127-11991-1-git-send-email-ping.bai@nxp.com>
 <1527234127-11991-2-git-send-email-ping.bai@nxp.com>
Message-ID: <20180611082411.GH16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 03:42:07PM +0800, Bai Ping wrote:
> Add dts file support for imx6sll EVK board.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Dong Aisheng <Aisheng.dong@nxp.com>
> ---
>  change v3->v4
>  - update the license indentifier
>  - remove leading zero of node
>  - remove unused pin from hog group
>  change v4->v5
>  - use generic name for device node
>  - remove unnecessary hog pin group
>  change v5->v6
>  - no
>  change v6->v7
>  - move the iomuxc node to the end of dts file
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |   4 +
>  arch/arm/boot/dts/Makefile                    |   2 +
>  arch/arm/boot/dts/imx6sll-evk.dts             | 317 ++++++++++++++++++++++++++
>  3 files changed, 323 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6sll-evk.dts

<snip>

> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX6SLL_PAD_I2C1_SCL__I2C1_SCL	 0x4001b8b1
> +			MX6SLL_PAD_I2C1_SDA__I2C1_SDA	 0x4001b8b1
> +		>;
> +	};
> +};
> +
> +

The new blank line at EOF should be dropped.


I fixed it up and applied both patches.

Shawn
