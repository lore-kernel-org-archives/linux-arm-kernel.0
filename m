From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 28 Feb 2014 19:06:29 -0800
Subject: [PATCH 1/2] i2c: Add driver for Cadence I2C controller
In-Reply-To: <1393632046-20062-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1393632046-20062-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <8af0e222-6337-4ec4-b718-099a9decc5ec@TX2EHSMHS034.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-28 at 04:00PM -0800, Soren Brinkmann wrote:
> Add a driver for the Cadence I2C controller. This controller is for
> example found in Xilinx Zynq.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  .../devicetree/bindings/i2c/i2c-cadence.txt        |  21 +
>  MAINTAINERS                                        |   1 +
>  drivers/i2c/busses/Kconfig                         |   7 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-cadence.c                   | 901 +++++++++++++++++++++
>  5 files changed, 931 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cadence.txt
>  create mode 100644 drivers/i2c/busses/i2c-cadence.c
> 
[...]
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index f5ed03164d86..7806c1654068 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -375,6 +375,13 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
>  	help
>  	  The unit of the TWI clock is kHz.
>  
> +config I2C_CADENCE
> +	tristate "Cadence I2C Controller"
> +	depends on ARCH_ZYNQ
This can be reduced to a dependency on COMMON_CLK only, I think.

	S?ren
