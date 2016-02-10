From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 10 Feb 2016 18:17:38 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: use armada-370-sata for SATA on
 Armada 375
In-Reply-To: <1455121756-20804-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455121756-20804-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160210171738.GC9492@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 05:29:15PM +0100, Thomas Petazzoni wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> The Armada 375 has the same SATA IP as Armada 370 and Armada XP, which
> requires the PHY speed to be set in the LP_PHY_CTL register for SATA
> hotplug to work.
> 
> Therefore, this commit updates the compatible string used to describe
> the SATA IP in Armada 375 from marvell,orion-sata to
> marvell,armada-370-sata.
> 
> Fixes: 4de59085091f753d08c8429d756b46756ab94665 ("ARM: mvebu: add Device Tree description of the Armada 375 SoC")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks for adding the tags,
       
       Andrew

> ---
> Changes since v1:
>  - Add Fixes: tag, and add stable@ in Cc, as suggested by Andrew Lunn.
> ---
>  arch/arm/boot/dts/armada-375.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> index 7ccce75..cc952cf 100644
> --- a/arch/arm/boot/dts/armada-375.dtsi
> +++ b/arch/arm/boot/dts/armada-375.dtsi
> @@ -529,7 +529,7 @@
>  			};
>  
>  			sata at a0000 {
> -				compatible = "marvell,orion-sata";
> +				compatible = "marvell,armada-370-sata";
>  				reg = <0xa0000 0x5000>;
>  				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&gateclk 14>, <&gateclk 20>;
> -- 
> 2.6.4
> 
