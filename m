From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Sep 2016 15:28:50 +0100
Subject: [PATCH][V2] dma-mapping: add in missing white space in error
 message text
In-Reply-To: <20160912130952.2778-1-colin.king@canonical.com>
References: <20160912130952.2778-1-colin.king@canonical.com>
Message-ID: <20160912142849.GV1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 02:09:52PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A dev_warn message spans two lines and the literal string is missing
> a white space between words. Add the white space and reformat the
> message to not span multiple lines.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/arm/common/dmabounce.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
> index 3012816..afeb5e3 100644
> --- a/arch/arm/common/dmabounce.c
> +++ b/arch/arm/common/dmabounce.c
> @@ -546,9 +546,7 @@ void dmabounce_unregister_dev(struct device *dev)
>  	set_dma_ops(dev, NULL);
>  
>  	if (!device_info) {
> -		dev_warn(dev,
> -			 "Never registered with dmabounce but attempting"
> -			 "to unregister!\n");
> +		dev_warn(dev, "Never registered with dmabounce but attempting to unregister!\n");

Almost!

		dev_warn(dev,
			 "Never registered with dmabounce but attempting to unregister!\n");

The point is that the string is as greppable as possible, while trying to
keep to the rest of the style.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
