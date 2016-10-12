From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 12 Oct 2016 05:42:10 -0700
Subject: [RFC PATCH 02/11] pci: endpoint: introduce configfs entry for
 configuring EP functions
In-Reply-To: <1473829927-20466-3-git-send-email-kishon@ti.com>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <1473829927-20466-3-git-send-email-kishon@ti.com>
Message-ID: <20161012124210.GB942@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 10:41:58AM +0530, Kishon Vijay Abraham I wrote:
> diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
> index a6d827c..f1dd206 100644
> --- a/drivers/pci/endpoint/Kconfig
> +++ b/drivers/pci/endpoint/Kconfig
> @@ -13,7 +13,9 @@ config PCI_ENDPOINT
>  
>  	   Enabling this option will build the endpoint library, which
>  	   includes endpoint controller library and endpoint function
> -	   library.
> +	   library. This will also enable the configfs entry required to
> +	   configure the endpoint function and used to bind the
> +	   function with a endpoint controller.
>  
>  	   If in doubt, say "N" to disable Endpoint support.

This needs to grow a

	depends on CONFIGFS_FS

> +/**
> + * pci-ep-cfs.c - configfs to configure the PCI endpoint

Please don't use the file name in the top of the file comment, it's
only bound to get out of date..

> +struct pci_epf_info {
> +	struct config_item pci_epf;
> +	struct pci_epf *epf;
> +};

Any reason not to simply embedd the config_item into the pci_epf structure?
