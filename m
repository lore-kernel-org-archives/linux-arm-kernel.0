From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 30 Jul 2013 11:40:35 -0400
Subject: [PATCH] do not allow XEN_TMEM on ARM64
In-Reply-To: <alpine.DEB.2.02.1307231745520.4893@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1307231745520.4893@kaball.uk.xensource.com>
Message-ID: <20130730154035.GA9245@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 05:46:58PM +0100, Stefano Stabellini wrote:
> tmem is not supported on arm or arm64 yet.

So .. I lost track of the conversation about this. We chatted
about this on the hyepervisor side and then there is also
this patch.


What did we decide?

> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 9e02d60..a18f350 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -145,7 +146,7 @@ config SWIOTLB_XEN
>  
>  config XEN_TMEM
>  	tristate
> -	depends on !ARM
> +	depends on !ARM && !ARM64
>  	default m if (CLEANCACHE || FRONTSWAP)
>  	help
>  	  Shim to interface in-kernel Transcendent Memory hooks
