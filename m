From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 10:38:54 +0100
Subject: [PATCH v2 net-next] net: hisilicon: fix binding document of mdio
In-Reply-To: <1447666704-200773-1-git-send-email-huangdaode@hisilicon.com>
References: <1447666704-200773-1-git-send-email-huangdaode@hisilicon.com>
Message-ID: <6897029.2fyR9qGpEn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 November 2015 17:38:24 huangdaode wrote:
> This patch explains the occasion of "hisilcon,mdio" and
> "hisilicon,hns-mdio" according to Arnd's comments.
> and reformat it according to comments from Rob<robh@kernel.org>.
> 
> chang log:
> 
> v2:
>   1) reformat the style.
>   2) make it more clearity.
> 
> v1:
>   initial version.
> 
> Signed-off-by: huangdaode <huangdaode@hisilicon.com>
> ---

The new version looks ok, but your changelog above is formatted
incorrectly. Please put only the contents you want in the git history
above the '---' line and your Signed-off-by, but put the parts that
refer to previous versions of the submission below the ---.

>  Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
> index 9c23fdf..4942d20 100644
> --- a/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
> +++ b/Documentation/devicetree/bindings/net/hisilicon-hns-mdio.txt
> @@ -1,7 +1,12 @@
>  Hisilicon MDIO bus controller
>  
>  Properties:
> -- compatible: "hisilicon,mdio","hisilicon,hns-mdio".
> +- compatible: can be one of:
> +	"hisilicon,hns-mdio"
> +	"hisilicon,mdio"
> +  "hisilicon,hns-mdio" is recommendly to be used for hip05 and later SOCs,
> +  while "hisilicon,mdio" is optional for backwards compatibility, only
> +  support for hip04 Soc.
>  - reg: The base address of the MDIO bus controller register bank.
>  - #address-cells: Must be <1>.
>  - #size-cells: Must be <0>.  MDIO addresses have no size component.
> 
