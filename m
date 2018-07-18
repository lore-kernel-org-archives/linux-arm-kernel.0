From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 18 Jul 2018 18:28:49 +0200
Subject: [PATCH 1/5] net: visually shrink eth_platform_get_mac_address()
In-Reply-To: <20180718161035.7005-2-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-2-brgl@bgdev.pl>
Message-ID: <20180718162849.GA12477@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 06:10:31PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Initialize the variables with proper values so that we save a few
> lines of code before we extend this function in the follow-up patches.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  net/ethernet/eth.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index ee28440f57c5..da8530879e1e 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -527,15 +527,10 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>  
>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  {
> -	const unsigned char *addr;
> -	struct device_node *dp;
> +	struct device_node *dp = dev_is_pci(dev) ?
> +			pci_device_to_OF_node(to_pci_dev(dev)) : dev->of_node;
> +	const unsigned char *addr = NULL;

Hi Bartosz

You are now in the net subsystem, which has its own set of additional
coding styles. One of them is reverse Christmas tree.

You might want to read Documentation/networking/netdev-FAQ.txt.

    Andrew
