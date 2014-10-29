From: msalter@redhat.com (Mark Salter)
Date: Wed, 29 Oct 2014 12:23:37 -0400
Subject: [PATCH RESEND 1/7] arm64: dts: Add APM X-Gene USB DTS node
In-Reply-To: <1414438108-8384-2-git-send-email-fkan@apm.com>
References: <1414438108-8384-1-git-send-email-fkan@apm.com>
 <1414438108-8384-2-git-send-email-fkan@apm.com>
Message-ID: <1414599817.1870.15.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-10-27 at 12:28 -0700, Feng Kan wrote:
> This parch adds the device tree nodes for APM X-Gnene USB host controller.
> Since X-Gene SOC supports maximum 2 USB ports, 2 dts node are added.
> 
> Signed-off-by: Bao Truong <btruong@apm.com>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  arch/arm64/boot/dts/apm-storm.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
> index 3eef74b..a80f2fa 100644
> --- a/arch/arm64/boot/dts/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm-storm.dtsi
> @@ -587,6 +587,20 @@
>  			phy-names = "sata-phy";
>  		};
>  
> +		usb0: dwusb at 19000000 {
> +			status = "disabled";
> +			compatible = "xhci-platform";
> +			reg =  <0x0 0x19000000 0x0 0x100000>;
> +			interrupts = <0x0 0x89 0x4>;
> +		};
> +
> +		usb1: dwusb at 19800000 {
> +			status = "disabled";
> +			compatible = "xhci-platform";
> +			reg =  <0x0 0x19800000 0x0 0x100000>;
> +			interrupts = <0x0 0x8a 0x4>;
> +		};
> +

Should these have "dma-coherent" properties?
