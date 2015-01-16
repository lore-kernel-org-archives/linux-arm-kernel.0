From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 15 Jan 2015 18:49:37 -0600
Subject: [PATCH 13/28] pci: host: drop owner assignment from
 platform_drivers
In-Reply-To: <1419196495-9626-14-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
 <1419196495-9626-14-git-send-email-wsa@the-dreams.de>
Message-ID: <20150116004937.GG29776@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Julia]

On Sun, Dec 21, 2014 at 10:14:34PM +0100, Wolfram Sang wrote:
> This platform_driver does not need to set an owner, it will be populated by the
> driver core.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

I already applied the equivalent patch from Julia for v3.20, thanks!
(I know this is my fault because it took me so long to apply Julia's
patch.)

> ---
> Generated with coccinelle. SmPL file is in the introductory msg. The big
> cleanup was pulled in this merge window. This series catches the bits fallen
> through. The patches shall go in via the subsystem trees.
> 
>  drivers/pci/host/pci-layerscape.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 6697b1a4d4fa..68c9e5e9b0a8 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -167,7 +167,6 @@ MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
>  static struct platform_driver ls_pcie_driver = {
>  	.driver = {
>  		.name = "layerscape-pcie",
> -		.owner = THIS_MODULE,
>  		.of_match_table = ls_pcie_of_match,
>  	},
>  };
> -- 
> 2.1.3
> 
