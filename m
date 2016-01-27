From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 27 Jan 2016 18:13:35 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: use armada-370-sata for SATA on
 Armada 375
In-Reply-To: <1453908287-29557-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1453908287-29557-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453908287-29557-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160127171335.GF20194@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 04:24:46PM +0100, Thomas Petazzoni wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> The Armada 375 has the same SATA IP as Armada 370 and Armada XP, which
> requires the PHY speed to be set in the LP_PHY_CTL register for SATA
> hotplug to work.

Hi Thomas

Should this have a fixes: tag?

       Andrew

> 
> Therefore, this commit updates the compatible string used to describe
> the SATA IP in Armada 375 from marvell,orion-sata to
> marvell,armada-370-sata.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
