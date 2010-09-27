From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 27 Sep 2010 13:07:50 +0200
Subject: [PATCH v2 07/10] TWL CORE: Fix sparse warning
In-Reply-To: <1285063280-4057-8-git-send-email-manjugk@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	<1285063280-4057-8-git-send-email-manjugk@ti.com>
Message-ID: <20100927110750.GE2560@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manjunath,

On Tue, Sep 21, 2010 at 03:31:17PM +0530, G, Manjunath Kondaiah wrote:
> Fixes below sparse warning.
> 
> drivers/mfd/twl-core.c:258:20: warning: symbol 'twl_map' was not declared. Should it be static?
> 
Patch applied, thanks.

Cheers,
Samuel.

> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
>  drivers/mfd/twl-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 720e099..53c371a 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -255,7 +255,7 @@ struct twl_mapping {
>  	unsigned char sid;	/* Slave ID */
>  	unsigned char base;	/* base address */
>  };
> -struct twl_mapping *twl_map;
> +static struct twl_mapping *twl_map;
>  
>  static struct twl_mapping twl4030_map[TWL4030_MODULE_LAST + 1] = {
>  	/*
> -- 
> 1.7.0.4
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
