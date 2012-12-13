From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 13 Dec 2012 16:31:00 +0100
Subject: [PATCH v2] ARM: dts: add macb mii pinctrl config for kizbox
In-Reply-To: <1355407388-7294-1-git-send-email-linux-arm@overkiz.com>
References: <1355407388-7294-1-git-send-email-linux-arm@overkiz.com>
Message-ID: <20121213153100.GF23971@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:03 Thu 13 Dec     , Boris BREZILLON wrote:
> Hello,
> 
> This patch overrides default macb pinctrl config defined in 
> at91sam9260.dtsi (pinctrl_macb_rmii) with kizbox board config 
> (pinctrl_macb_rmii + pinctrl_macb_rmii_mii_alt).
> 
> changes since v1 :
> 	- add missing rmii signals to pinctrl config.
> 
> Regards,
> 
> Boris
those comment belong
> 
> Signed-off-by: Boris BREZILLON <linux-arm@overkiz.com>
> ---
here

will fix at apply time but I do not known if it will be for 3.8 or 3.9

Best Regards,
J.
> diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/kizbox.dts
> index e8814fe..b4dc3ed 100644
> --- a/arch/arm/boot/dts/kizbox.dts
> +++ b/arch/arm/boot/dts/kizbox.dts
> @@ -48,6 +48,8 @@
>  
>  			macb0: ethernet at fffc4000 {
>  				phy-mode = "mii";
> +				pinctrl-0 = <&pinctrl_macb_rmii
> +				             &pinctrl_macb_rmii_mii_alt>;
>  				status = "okay";
>  			};
>  
> -- 
> 1.7.9.5
> 
