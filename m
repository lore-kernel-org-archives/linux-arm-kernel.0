From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 25 Mar 2015 15:11:52 +0100
Subject: [PATCH] component: fix build warning on arm64 builds
In-Reply-To: <E1YOjQi-0002Tw-QT@rmk-PC.arm.linux.org.uk>
References: <E1YOjQi-0002Tw-QT@rmk-PC.arm.linux.org.uk>
Message-ID: <20150325141152.GA22063@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 08:59:24AM +0000, Russell King wrote:
> Fix:
> drivers/base/component.c: In function 'find_components':
> drivers/base/component.c:97:3: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'size_t' [-Wformat]
> on ARM64 builds.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/base/component.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index a6f2050d17b7..d99b06b341fb 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -94,7 +94,7 @@ static int find_components(struct master *master)
>  	for (i = 0; i < match->num; i++) {
>  		struct component *c;
>  
> -		dev_dbg(master->dev, "Looking for component %u\n", i);
> +		dev_dbg(master->dev, "Looking for component %zu\n", i);
>  
>  		if (match->compare[i].component)
>  			continue;
> -- 
> 1.8.3.1

Doesn't apply to my tree, is this already upstream?

thanks,

greg k-h
