From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 26 May 2014 22:30:46 +0300
Subject: [PATCH 1/3] driver core/platform: don't leak memory allocated
 for dma_mask
In-Reply-To: <1401122483-31603-1-git-send-email-emilgoode@gmail.com>
References: <1401122483-31603-1-git-send-email-emilgoode@gmail.com>
Message-ID: <20140526193046.GJ15585@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 06:41:21PM +0200, Emil Goode wrote:
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 9e9227e..dd1fa07 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -166,6 +166,7 @@ EXPORT_SYMBOL_GPL(platform_add_devices);
>  struct platform_object {
>  	struct platform_device pdev;
>  	char name[1];
> +	u64 dma_mask;
>  };

Heh.  No this doesn't work as patch #1.  You have to have name at the
end of the struct.

regards,
dan carpenter
