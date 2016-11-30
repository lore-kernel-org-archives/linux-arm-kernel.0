From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 30 Nov 2016 10:43:43 +0000
Subject: [PATCH] arm64: dts: juno: Correct PCI IO window
In-Reply-To: <1480452310-29286-1-git-send-email-jeremy.linton@arm.com>
References: <1480452310-29286-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <20161130104343.GA13903@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 02:45:10PM -0600, Jeremy Linton wrote:
> The PCIe root complex on Juno translates the MMIO mapped
> at 0x5f800000 to the PIO address range starting at 0
> (which is common because PIO addresses are generally < 64k).
> Correct the DT to reflect this.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index 334271a..7d3a2ac 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -393,7 +393,7 @@
>  		#address-cells = <3>;
>  		#size-cells = <2>;
>  		dma-coherent;
> -		ranges = <0x01000000 0x00 0x5f800000 0x00 0x5f800000 0x0 0x00800000>,
> +		ranges = <0x01000000 0x00 0x00000000 0x00 0x5f800000 0x0 0x00800000>,
>  			 <0x02000000 0x00 0x50000000 0x00 0x50000000 0x0 0x08000000>,
>  			 <0x42000000 0x40 0x00000000 0x40 0x00000000 0x1 0x00000000>;
>  		#interrupt-cells = <1>;
> -- 
> 2.5.5
> 
