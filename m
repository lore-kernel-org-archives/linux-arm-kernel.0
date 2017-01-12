From: davem@davemloft.net (David Miller)
Date: Thu, 12 Jan 2017 16:21:35 -0500 (EST)
Subject: [PATCH net-next v2 05/10] drivers: base: Add device_find_class()
In-Reply-To: <20170112034121.27697-6-f.fainelli@gmail.com>
References: <20170112034121.27697-1-f.fainelli@gmail.com>
 <20170112034121.27697-6-f.fainelli@gmail.com>
Message-ID: <20170112.162135.441956368122992032.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 11 Jan 2017 19:41:16 -0800

> Add a helper function to lookup a device reference given a class name.
> This is a preliminary patch to remove adhoc code from net/dsa/dsa.c and
> make it more generic.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/base/core.c    | 19 +++++++++++++++++++
>  include/linux/device.h |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 020ea7f05520..3dd6047c10d8 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2065,6 +2065,25 @@ struct device *device_find_child(struct device *parent, void *data,
>  }
>  EXPORT_SYMBOL_GPL(device_find_child);
>  
> +static int dev_is_class(struct device *dev, void *class)

I know you are just moving code, but this class argumnet is a string
and thus should be "char *" or even "const char *".
