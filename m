From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 13 Dec 2012 13:00:01 +0100
Subject: [PATCH] ARM: dts: select appropriate macb pinctrl config for
 kizbox
In-Reply-To: <1354877464-5393-1-git-send-email-linux-arm@overkiz.com>
References: <1354877464-5393-1-git-send-email-linux-arm@overkiz.com>
Message-ID: <20121213120001.GA23971@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:51 Fri 07 Dec     , Boris BREZILLON wrote:
> Hello,
> 
> This patch overrides default macb pinctrl config defined in at91sam9260.dtsi
> (pinctrl_macb_rmii) with kizbox board config (pinctrl_macb_rmii_mii_alt).
> 
> Regards,
> 
> Boris
> 
> Signed-off-by: Boris BREZILLON <linux-arm@overkiz.com>
> ---
> diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/kizbox.dts
> index e8814fe..feffffe 100644
> --- a/arch/arm/boot/dts/kizbox.dts
> +++ b/arch/arm/boot/dts/kizbox.dts
> @@ -48,6 +48,7 @@
>  
>  			macb0: ethernet at fffc4000 {
>  				phy-mode = "mii";
> +				pinctrl-0 = <&pinctrl_macb_rmii_mii_alt>;
this can not work

just mux half of the signal

Best Regards,
J.
>  				status = "okay";
>  			};
>  
> -- 
> 1.7.9.5
> 
