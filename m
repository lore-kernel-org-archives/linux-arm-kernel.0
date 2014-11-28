From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Nov 2014 14:16:51 +0000
Subject: [PATCH v3 2/4] mmc: atmel-mci: remove __init/__exit attributes
In-Reply-To: <1417183686-31481-3-git-send-email-ludovic.desroches@atmel.com>
References: <1417183686-31481-1-git-send-email-ludovic.desroches@atmel.com>
 <1417183686-31481-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20141128141651.GS3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 03:08:04PM +0100, Ludovic Desroches wrote:
> Using __init/__exit attributes can cause several breakages so remove
> them.

I've really no idea why people jump overboard with these things - it
seems people go from one extreme to the other (adding lots of __init /
__exit annotations everywhere to removing them all), but:

> @@ -2573,12 +2573,12 @@ static struct platform_driver atmci_driver = {
>  	},
>  };
>  
> -static int __init atmci_init(void)
> +static int atmci_init(void)
>  {
>  	return platform_driver_probe(&atmci_driver, atmci_probe);
>  }
>  
> -static void __exit atmci_exit(void)
> +static void atmci_exit(void)
>  {
>  	platform_driver_unregister(&atmci_driver);
>  }

These last two are totally fine to leave there.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
