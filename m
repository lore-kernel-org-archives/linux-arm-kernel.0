From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 17 Jul 2017 15:35:25 +0100
Subject: [PATCH] mfd: ab8500-core: constify attribute_group structures.
In-Reply-To: <82391b6661b206976c244dcef76946c45c6aac2d.1499664942.git.arvind.yadav.cs@gmail.com>
References: <82391b6661b206976c244dcef76946c45c6aac2d.1499664942.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170717143525.iyv2nmjflzattir3@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jul 2017, Arvind Yadav wrote:

> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work with const
> attribute_group. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>   16298	   1009	    184	  17491	   4453	drivers/mfd/ab8500-core.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>   16490	    817	    184	  17491	   4453	drivers/mfd/ab8500-core.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/mfd/ab8500-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
> index 8511c06..30d09d1 100644
> --- a/drivers/mfd/ab8500-core.c
> +++ b/drivers/mfd/ab8500-core.c
> @@ -1059,15 +1059,15 @@ static DEVICE_ATTR(dbbrstn, S_IRUGO | S_IWUSR,
>  	NULL,
>  };
>  
> -static struct attribute_group ab8500_attr_group = {
> +static const struct attribute_group ab8500_attr_group = {
>  	.attrs	= ab8500_sysfs_entries,
>  };
>  
> -static struct attribute_group ab8505_attr_group = {
> +static const struct attribute_group ab8505_attr_group = {
>  	.attrs	= ab8505_sysfs_entries,
>  };
>  
> -static struct attribute_group ab9540_attr_group = {
> +static const struct attribute_group ab9540_attr_group = {
>  	.attrs	= ab9540_sysfs_entries,
>  };
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
