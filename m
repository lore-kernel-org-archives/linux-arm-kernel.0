From: Tirumalesh.Chalamarla@caviumnetworks.com (Chalamarla, Tirumalesh)
Date: Thu, 25 Jun 2015 23:19:59 +0000
Subject: [PATCH 2/6] GICv3: Add ITS entry to THUNDER dts
In-Reply-To: <1411573068-12952-3-git-send-email-rric@kernel.org>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <1411573068-12952-3-git-send-email-rric@kernel.org>
Message-ID: <9184A2BB-2852-4B73-B964-881A1491EEA8@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Any feed back on this. 
Do you want me to submit this as a separate patch?so that it is easy for getting acceptance. 

Thanks,
Tirumalesh. 

> On Sep 24, 2014, at 8:37 AM, Robert Richter <rric@kernel.org> wrote:
> 
> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> 
> The PCIe host controller uses MSIs provided by GICv3 ITS. Enable it on
> Thunder SoCs by adding an entry to DT.
> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
> arch/arm64/boot/dts/thunder-88xx.dtsi | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/thunder-88xx.dtsi b/arch/arm64/boot/dts/thunder-88xx.dtsi
> index d8c0bdc51882..9cb7cf94284a 100644
> --- a/arch/arm64/boot/dts/thunder-88xx.dtsi
> +++ b/arch/arm64/boot/dts/thunder-88xx.dtsi
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
