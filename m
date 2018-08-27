From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 27 Aug 2018 16:00:11 +0800
Subject: [PATCH v2 1/1] ARM: dts: imx6ull: keep IMX6UL_ prefix for
 signals on both i.MX6UL and i.MX6ULL
In-Reply-To: <20180822113803.20965-1-sebastien.szymanski@armadeus.com>
References: <20180822113803.20965-1-sebastien.szymanski@armadeus.com>
Message-ID: <20180827080008.GL3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2018 at 01:38:03PM +0200, S?bastien Szymanski wrote:
> Signals available on both i.MX6UL and i.MX6ULL should have the same name
> because it is the case of all others common signals, it avoids to make
> mistakes (use the wrong ones) and it makes writing device tree files
> less complicated. For example:
> 
> imx6ul-imx6ull-board.dtsi:
>  ...
>  pinctrl_uart5: uart5grp {
> 	fsl,pins = <
> 		MX6UL_PAD_UART5_TX_DATA__UART5_DCE_TX   0x1b0b1
> 	 	MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX   0x1b0b1
>  	 >;
>  };
> 
> imx6ul-board.dts:
>  #include <imx6ul.dtsi>
>  #include <imx6ul-imx6ull-board.dtsi>
>  ...
> 
> imx6ull-board.dts:
>  #include <imx6ull.dtsi>
>  #include <imx6ul-imx6ull-board.dtsi>
>  ...
> 
> Without this patch, the imx6ull-board.dtb will use
> MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX instead of
> MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX and the uart5 will be
> misconfigured.
> 
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>

Rob and Fabio gave their review/ack tags on v1, so I applied the patch
with the tags collected.

Shawn
