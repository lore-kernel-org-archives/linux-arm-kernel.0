From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 15 Jun 2015 05:28:42 +0200
Subject: [PATCH] ARM: orion5x: Use vsprintf %pM extension
In-Reply-To: <1434333690.2507.30.camel@perches.com>
References: <1434333690.2507.30.camel@perches.com>
Message-ID: <20150615032842.GD10886@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 14, 2015 at 07:01:30PM -0700, Joe Perches wrote:
> Format mac addresses with the normal kernel extension.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew

> ---
>  arch/arm/mach-orion5x/dns323-setup.c | 4 +---
>  arch/arm/mach-orion5x/tsx09-common.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
> index 09d2a26..f267e58 100644
> --- a/arch/arm/mach-orion5x/dns323-setup.c
> +++ b/arch/arm/mach-orion5x/dns323-setup.c
> @@ -236,9 +236,7 @@ static int __init dns323_read_mac_addr(void)
>  	}
>  
>  	iounmap(mac_page);
> -	printk("DNS-323: Found ethernet MAC address: ");
> -	for (i = 0; i < 6; i++)
> -		printk("%.2x%s", addr[i], (i < 5) ? ":" : ".\n");
> +	printk("DNS-323: Found ethernet MAC address: %pM\n", addr);
>  
>  	memcpy(dns323_eth_data.mac_addr, addr, 6);
>  
> diff --git a/arch/arm/mach-orion5x/tsx09-common.c b/arch/arm/mach-orion5x/tsx09-common.c
> index 7189827..24b2959 100644
> --- a/arch/arm/mach-orion5x/tsx09-common.c
> +++ b/arch/arm/mach-orion5x/tsx09-common.c
> @@ -101,9 +101,7 @@ static int __init qnap_tsx09_check_mac_addr(const char *addr_str)
>  		addr[i] = byte;
>  	}
>  
> -	printk(KERN_INFO "tsx09: found ethernet mac address ");
> -	for (i = 0; i < 6; i++)
> -		printk("%.2x%s", addr[i], (i < 5) ? ":" : ".\n");
> +	printk(KERN_INFO "tsx09: found ethernet mac address %pM\n", addr);
>  
>  	memcpy(qnap_tsx09_eth_data.mac_addr, addr, 6);
>  
> 
> 
