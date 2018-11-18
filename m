From: Nicolas.Ferre@microchip.com (Nicolas.Ferre at microchip.com)
Date: Sun, 18 Nov 2018 15:42:34 +0000
Subject: [PATCH v2 11/25] net: cadence: switch to using
 nvmem_get_mac_address()
In-Reply-To: <20181113140133.17385-12-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
 <20181113140133.17385-12-brgl@bgdev.pl>
Message-ID: <bd51c2fb-9f86-450a-74d1-0cba5c9e9cee@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/2018 at 15:01, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now have a generalized helper routine to read the MAC address from
> nvmem which takes struct device as argument. The nvmem subsystem will
> then try device tree first before all other potential providers.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 1d86b4d5645a..d9a208f7bb40 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4055,7 +4055,7 @@ static int macb_probe(struct platform_device *pdev)
>   	if (mac) {
>   		ether_addr_copy(bp->dev->dev_addr, mac);
>   	} else {
> -		err = of_get_nvmem_mac_address(np, bp->dev->dev_addr);
> +		err = nvmem_get_mac_address(&pdev->dev, bp->dev->dev_addr);
>   		if (err) {
>   			if (err == -EPROBE_DEFER)
>   				goto err_out_free_netdev;
> 


-- 
Nicolas Ferre
