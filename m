From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 19 Oct 2016 10:55:46 -0500
Subject: [PATCH 1/3] ARM: socfpga: dtsi: add qspi node
In-Reply-To: <20161018074304.6744-1-s.trumtrar@pengutronix.de>
References: <20161018074304.6744-1-s.trumtrar@pengutronix.de>
Message-ID: <alpine.DEB.2.02.1610191054120.29731@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Oct 2016, Steffen Trumtrar wrote:

> Add the qspi node to the socfpga dtsi file.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 9f48141270b8..0dc96d2248a6 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -705,6 +705,20 @@
>  			reg = <0xffff0000 0x10000>;
>  		};
>  
> +		qspi: spi at ff705000 {
> +			compatible = "cdns,qspi-nor";
> +                        #address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0xff705000 0x1000>,
> +			      <0xffa00000 0x1000>;

I think the QSPI data address space has a length of 0x100000. I've fixed it up locally.

BR,
Dinh
