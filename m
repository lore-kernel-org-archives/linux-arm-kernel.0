From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 24 Jul 2014 16:28:16 -0700
Subject: [PATCH v2 06/11] ARM: dts: zynq: Add DMAC for Parallella
In-Reply-To: <1406242820-20140-7-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-7-git-send-email-afaerber@suse.de>
Message-ID: <bc390439-9a5b-43a1-a70c-a4c6517a6cb6@BN1AFFO11FD005.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: New
>  
>  arch/arm/boot/dts/zynq-7000.dtsi      | 17 +++++++++++++++++
>  arch/arm/boot/dts/zynq-parallella.dts |  4 ++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index eed3df0..1a70277 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -223,6 +223,23 @@
>  			};
>  		};
>  
> +		dmac_s: dmac at f8003000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0xf8003000 0x1000>;
> +			status = "disabled";
I think for this IP we can omit the 'status' property since it is always
enabled. I don't see a reason to override it in each board DT.

> +			interrupt-parent = <&intc>;
> +			interrupts = <0 13 4>,
> +			             <0 14 4>, <0 15 4>,
> +			             <0 16 4>, <0 17 4>,
> +			             <0 40 4>, <0 41 4>,
> +			             <0 42 4>, <0 43 4>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <4>;
> +			clocks = <&clkc 27>;
> +			clock-names = "apb_pclk";
> +		};
> +

Acked-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
