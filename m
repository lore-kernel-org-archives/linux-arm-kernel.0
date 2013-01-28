From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 28 Jan 2013 10:04:23 +0000
Subject: [PATCH] mfd/vexpress: vexpress_sysreg_setup must not be __init
In-Reply-To: <1359140032-6039-1-git-send-email-arnd@arndb.de>
References: <1359140032-6039-1-git-send-email-arnd@arndb.de>
Message-ID: <1359367463.8090.9.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-25 at 18:53 +0000, Arnd Bergmann wrote:
> The patch 52666298a 'mfd: vexpress-sysreg: Don't skip initialization
> on probe' adds a call to vexpress_sysreg_setup from a non-__init
> function, so this also has to lose its __init annotation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: arm at kernel.org
> ---
>  drivers/mfd/vexpress-sysreg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
> index 77048b1..558c292 100644
> --- a/drivers/mfd/vexpress-sysreg.c
> +++ b/drivers/mfd/vexpress-sysreg.c
> @@ -313,7 +313,7 @@ static void vexpress_sysreg_config_complete(unsigned long data)
>  }
>  
> 
> -void __init vexpress_sysreg_setup(struct device_node *node)
> +void vexpress_sysreg_setup(struct device_node *node)
>  {
>  	if (WARN_ON(!vexpress_sysreg_base))
>  		return;

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel
