From: sergio.paracuellos@gmail.com (Sergio Paracuellos)
Date: Wed, 12 Sep 2018 07:35:50 +0200
Subject: [PATCH -next] staging: mt7621-pci: Use PTR_ERR_OR_ZERO in
 mt7621_pcie_parse_dt()
In-Reply-To: <1536720608-106123-1-git-send-email-yuehaibing@huawei.com>
References: <1536720608-106123-1-git-send-email-yuehaibing@huawei.com>
Message-ID: <20180912053550.GA17293@foobar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 02:50:08AM +0000, YueHaibing wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
> index ba1f117..d2cb910 100644
> --- a/drivers/staging/mt7621-pci/pci-mt7621.c
> +++ b/drivers/staging/mt7621-pci/pci-mt7621.c
> @@ -396,10 +396,7 @@ static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
>  	}
>  
>  	pcie->base = devm_ioremap_resource(dev, &regs);
> -	if (IS_ERR(pcie->base))
> -		return PTR_ERR(pcie->base);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(pcie->base);
>  }

This patch looks good but the 'mt7621_pcie_parse_dt' function is not completed at all.
There is a lot of missing for each pci node to be parsed yet and some patch series which
are doing this have not been tested yet so those patches are not included.

Please see: 
    http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-September/125937.html

Best regards,
    Sergio Paracuellos

>  
>  static int mt7621_pcie_request_resources(struct mt7621_pcie *pcie,
> 
> 
> 
