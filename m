From: robh@kernel.org (Rob Herring)
Date: Tue, 7 Aug 2018 11:59:02 -0600
Subject: [PATCH 1/1] ARM: dts: imx6ull: keep IMX6UL_ prefix for signals
 on both i.MX6UL and i.MX6ULL
In-Reply-To: <20180720102321.23291-1-sebastien.szymanski@armadeus.com>
References: <20180720102321.23291-1-sebastien.szymanski@armadeus.com>
Message-ID: <20180807175902.GA2389@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 12:23:21PM +0200, S?bastien Szymanski wrote:
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
> ---
>  arch/arm/boot/dts/imx6ull-pinfunc.h | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)

This may be less error prone, but it is ugly still.

Acked-by: Rob Herring <robh@kernel.org>
