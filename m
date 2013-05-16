From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 16 May 2013 11:51:56 +0200
Subject: [PATCH] ASoC: dfbmcs320: make the driver common for other BT
 modules
In-Reply-To: <1368687184-12169-1-git-send-email-Baohua.Song@csr.com>
References: <1368687184-12169-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <5194AC3C.4080206@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 08:53 AM, Barry Song wrote:
> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
> we don't want everyone to have a seperate codec driver. anyway, the
> feature of Bluetooth handsfree is same on all platforms, so this patch
> makes the DFBM-CS320 driver become a common BT handsfree driver.
[...]
> -static struct platform_driver dfmcs320_driver = {
> +static struct platform_driver bt_handsfree_driver = {
>  	.driver = {
> -		.name = "dfbmcs320",
> +		.name = "bt-handsfree",
>  		.owner = THIS_MODULE,

In my opinion it's a good idea to keep a platform_id list of all the
supported devices.

>  	},
> -	.probe = dfbmcs320_probe,
> -	.remove = dfbmcs320_remove,
> +	.probe = bt_handsfree_probe,
> +	.remove = bt_handsfree_remove,
>  };
>  
> -module_platform_driver(dfmcs320_driver);
> +module_platform_driver(bt_handsfree_driver);
