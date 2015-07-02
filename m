From: Tirumalesh.Chalamarla@caviumnetworks.com (Chalamarla, Tirumalesh)
Date: Thu, 2 Jul 2015 20:26:02 +0000
Subject: [PATCH] GICv3: Add ITS entry to THUNDER dts
In-Reply-To: <1435345943-31833-1-git-send-email-tchalamarla@caviumnetworks.com>
References: <1435345943-31833-1-git-send-email-tchalamarla@caviumnetworks.com>
Message-ID: <D2BD6D7B-E4B2-46B8-A324-9261DCFA2642@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

is it possible to pull this for 4.2?

Thanks,
Tirumalesh.  
> On Jun 26, 2015, at 12:12 PM, Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com> wrote:
> 
> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> 
> The PCIe host controller uses MSIs provided by GICv3 ITS. Enable it on
> Thunder SoCs by adding an entry to DT.
> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> arch/arm64/boot/dts/cavium/thunder-88xx.dtsi | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> index d8c0bdc..9cb7cf9 100644
> --- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> +++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> @@ -376,10 +376,19 @@
> 		gic0: interrupt-controller at 8010,00000000 {
> 			compatible = "arm,gic-v3";
> 			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> 			interrupt-controller;
> 			reg = <0x8010 0x00000000 0x0 0x010000>, /* GICD */
> 			      <0x8010 0x80000000 0x0 0x600000>; /* GICR */
> 			interrupts = <1 9 0xf04>;
> +
> +			its: gic-its at 8010,00020000 {
> +				compatible = "arm,gic-v3-its";
> +				msi-controller;
> +				reg = <0x8010 0x20000 0x0 0x200000>;
> +			};
> 		};
> 
> 		uaa0: serial at 87e0,24000000 {
> -- 
> 2.1.0
> 
