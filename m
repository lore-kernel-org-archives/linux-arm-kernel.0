From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 14 Jul 2015 18:02:06 -0500
Subject: [PATCH] pci: Drop owner assignment from platform_driver
In-Reply-To: <1436510306-5788-1-git-send-email-k.kozlowski@samsung.com>
References: <1436510306-5788-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150714230206.GR24416@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 03:38:26PM +0900, Krzysztof Kozlowski wrote:
> platform_driver does not need to set an owner because
> platform_driver_register() will set it.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied to pci/host-xgene for v4.3, thanks!

> 
> ---
> 
> The coccinelle script which generated the patch was sent here:
> http://www.spinics.net/lists/kernel/msg2029903.html
> ---
>  drivers/pci/host/pci-xgene-msi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
> index 2d31d4d6fd08..9e1889e6aec7 100644
> --- a/drivers/pci/host/pci-xgene-msi.c
> +++ b/drivers/pci/host/pci-xgene-msi.c
> @@ -582,7 +582,6 @@ error:
>  static struct platform_driver xgene_msi_driver = {
>  	.driver = {
>  		.name = "xgene-msi",
> -		.owner = THIS_MODULE,
>  		.of_match_table = xgene_msi_match_table,
>  	},
>  	.probe = xgene_msi_probe,
> -- 
> 1.9.1
> 
