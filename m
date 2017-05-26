From: puck.chen@hisilicon.com (Chen Feng)
Date: Fri, 26 May 2017 11:12:59 +0800
Subject: [PATCH] reset: hisilicon: Fix hi6220 module license
In-Reply-To: <20170525092232.27960-1-afaerber@suse.de>
References: <20170525092232.27960-1-afaerber@suse.de>
Message-ID: <59279D3B.6090804@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

looks good to me.

On 2017/5/25 17:22, Andreas F?rber wrote:
> The hi6220_reset driver fails to load:
>
>   [   10.423640] hi6220_reset: module license 'unspecified' taints kernel.
>   [   10.423644] Disabling lock debugging due to kernel taint
>   [   10.423735] hi6220_reset: Unknown symbol regmap_write (err 0)
>   [   10.423747] hi6220_reset: Unknown symbol devm_kmalloc (err 0)
>   [   10.423759] hi6220_reset: Unknown symbol syscon_node_to_regmap (err 0)
>   [   10.423768] hi6220_reset: Unknown symbol reset_controller_register (err 0)
>   [   10.423784] hi6220_reset: Unknown symbol __platform_driver_register (err 0)
>
> Add a MODULE_LICENSE() to fix this.
>
> Fixes: 70b3590f639f ("reset: hi6220: fix modular build")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  drivers/reset/hisilicon/hi6220_reset.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
> index 35ce53edabf9..d5e5229308f2 100644
> --- a/drivers/reset/hisilicon/hi6220_reset.c
> +++ b/drivers/reset/hisilicon/hi6220_reset.c
> @@ -155,3 +155,5 @@ static int __init hi6220_reset_init(void)
>  }
>  
>  postcore_initcall(hi6220_reset_init);
> +
> +MODULE_LICENSE("GPL v2");
