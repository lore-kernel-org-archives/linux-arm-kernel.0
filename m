From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Nov 2015 08:44:57 -0600
Subject: [PATCH] net: hisilicon: fix binding document of mdio
In-Reply-To: <1447381424-107248-1-git-send-email-huangdaode@hisilicon.com>
References: <1447381424-107248-1-git-send-email-huangdaode@hisilicon.com>
Message-ID: <20151113144457.GA18563@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2015 at 10:23:44AM +0800, huangdaode wrote:
> This patch fixes explain the occasion of "hisilcon,mdio" according to
> Arnd's comments. specify it is only used for hip04.
> 
> First, please give your commnents.
> 
> Signed-off-by: huangdaode <huangdaode@hisilicon.com>
> ---
>  Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
> index 9c23fdf..f650e78 100644
> --- a/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
> +++ b/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
> @@ -1,7 +1,9 @@
>  Hisilicon MDIO bus controller
>  
>  Properties:
> -- compatible: "hisilicon,mdio","hisilicon,hns-mdio".
> +- compatible: can be one of "hisilicon,hns-mdio","hisilicon,mdio",
> +  for hip04 board, please use "hisilicon,mdio",
> +  other boards, "hisilicon,hns-mdio" is OK.

Please reformat like this:

- compatible: can be one of:
	"hisilicon,hns-mdio"
	"hisilicon,mdio"
  For hip04 board, must be "hisilicon,mdio".
  Otherwise, must be "hisilicon,hns-mdio".

>  - reg: The base address of the MDIO bus controller register bank.
>  - #address-cells: Must be <1>.
>  - #size-cells: Must be <0>.  MDIO addresses have no size component.
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
