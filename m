From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Mon, 22 Sep 2014 09:55:36 +0000
Subject: [PATCH v5] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <1411360807-7750-1-git-send-email-pankaj.dubey@samsung.com>
References: <1411360807-7750-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <d986e3e3ea4d410ea3dab7483c89d640@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[...]
> +static struct regmap_config syscon_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
>  };
> 
> -static int syscon_match_node(struct device *dev, void *data)
> +static struct syscon *of_syscon_register(struct device_node *np)
>  {
> -	struct device_node *dn = data;
> +	struct platform_device *pdev = NULL;

struct platform_device *pdev; ?

Thanks,

BRs
Xiubo
