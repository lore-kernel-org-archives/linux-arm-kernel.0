From: liviu.dudau@arm.com (liviu.dudau at arm.com)
Date: Wed, 30 Nov 2016 10:04:46 +0000
Subject: [PATCH] arm64: dts: juno: Correct PCI IO window
In-Reply-To: <1480452310-29286-1-git-send-email-jeremy.linton@arm.com>
References: <1480452310-29286-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <20161130100445.GJ1005@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 02:45:10PM -0600, Jeremy Linton wrote:
> The PCIe root complex on Juno translates the MMIO mapped
> at 0x5f800000 to the PIO address range starting at 0
> (which is common because PIO addresses are generally < 64k).
> Correct the DT to reflect this.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

With the U-Boot patch that I have sent to the ML:
Tested-by: Liviu Dudau <Liviu.Dudau@arm.com>

also

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Best regards,
Liviu


> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
