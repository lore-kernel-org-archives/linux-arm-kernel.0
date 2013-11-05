From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Nov 2013 08:29:05 -0500
Subject: [PATCH v3 25/28] ARM: mvebu: Add support for NAND controller
 in Armada 370/XP
In-Reply-To: <1383656135-8627-26-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-26-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131105132905.GJ3060@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 09:55:32AM -0300, Ezequiel Garcia wrote:
> The Armada 370 and Armada XP SoC have a NAND controller (aka NFCv2).
> This commit adds support for it in Armada 370 and Armada XP SoC
> common devicetree.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 01e69fc..b4e6898 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -258,6 +258,15 @@
>  				status = "disabled";
>  			};
>  
> +			nand at d0000 {
> +				compatible = "marvell,armada370-nand";

Could you please provide a separate patch updating the devicetree
binding documentation?  You can also Cc the entire series to the
devicetree ml as long as the documentation patch is easy to find in the
series.  eg 'dt: binding: ...'

thx,

Jason.
