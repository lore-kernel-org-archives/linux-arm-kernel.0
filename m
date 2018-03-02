From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Mar 2018 10:40:37 -0600
Subject: [PATCH v2 2/8] arm64: zynqmp: Add support for Xilinx zcu100-revC
In-Reply-To: <26229dbbeb0ced5db870a8cf636f6d3d5855199e.1519396753.git.michal.simek@xilinx.com>
References: <cover.1519396753.git.michal.simek@xilinx.com>
 <26229dbbeb0ced5db870a8cf636f6d3d5855199e.1519396753.git.michal.simek@xilinx.com>
Message-ID: <20180302164037.5mzzc4ixxvph46bf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 03:40:24PM +0100, Michal Simek wrote:
> This board has 2GB of memory, i2c, sd, wifi sdio, spis, uarts, display
> port and usbs.
> Board is using fixed clocks because clock driver hasn't been merged yet.

Please get rid of the separate clocks dts file when it is merged.

> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Use i2c-mux instead of i2cswitch
> - Remove i2c mw u-boot commands
> - Use 96boards labels for i2cs and spis
> - Fix pmic and wifi node
> - Record compatible string to xilinx.txt
> - Remove Nathalie's email (she left Xilinx already)
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt  |   6 +
>  arch/arm64/boot/dts/xilinx/Makefile               |   1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi        | 213 ++++++++++++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 292 ++++++++++++++++++++++
>  4 files changed, 512 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts

Reviewed-by: Rob Herring <robh@kernel.org> 
