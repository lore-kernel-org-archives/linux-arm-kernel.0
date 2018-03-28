From: s-anna@ti.com (Suman Anna)
Date: Wed, 28 Mar 2018 17:20:50 -0500
Subject: [PATCH v3 6/8] remoteproc/davinci: use octal permissions for
 module_param()
In-Reply-To: <20180327092031.11251-7-brgl@bgdev.pl>
References: <20180327092031.11251-1-brgl@bgdev.pl>
 <20180327092031.11251-7-brgl@bgdev.pl>
Message-ID: <13fa1d05-a3e3-64b5-9be1-5d08d1a708e3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2018 04:20 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Checkpatch recommends to use octal perms instead of S_IRUGO.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index f134192922e0..b668e32996e2 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -25,7 +25,7 @@
>  #include "remoteproc_internal.h"
>  
>  static char *da8xx_fw_name;
> -module_param(da8xx_fw_name, charp, S_IRUGO);
> +module_param(da8xx_fw_name, charp, 0444);
>  MODULE_PARM_DESC(da8xx_fw_name,
>  		 "Name of DSP firmware file in /lib/firmware (if not specified defaults to 'rproc-dsp-fw')");
>  
> 
