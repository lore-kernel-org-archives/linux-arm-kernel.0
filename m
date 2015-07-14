From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 14 Jul 2015 13:33:09 -0500
Subject: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe
 switch is attached
In-Reply-To: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
References: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
Message-ID: <20150714183309.GB24416@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 09:56:54AM +0200, David M?ller wrote:
> This problem has already been reported as 
> https://bugzilla.kernel.org/show_bug.cgi?id=100031
> 
> Signed-off-by: David M?ller <dave.mueller@gmx.ch>

Dropping for now, hoping for an update addressing the review comments.

> ---
>  drivers/pci/host/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index fdb9536..c63691c 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -489,7 +489,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>  		 * Wait a little bit, then re-check if the link finished
>  		 * the training.
>  		 */
> -		usleep_range(1000, 2000);
> +		mdelay(20);
>  	}
>  	/*
>  	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
> -- 
> 1.8.4
> 
