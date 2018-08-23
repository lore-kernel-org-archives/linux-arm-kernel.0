From: rdunlap@infradead.org (Randy Dunlap)
Date: Thu, 23 Aug 2018 10:43:10 -0700
Subject: [RFC 1/3 net] lorawan: Add LoRaWAN class module
In-Reply-To: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
References: <cover.1535039998.git.starnight@g.ncu.edu.tw>
 <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
Message-ID: <30b75248-7589-fc98-819f-2b68844522f1@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/23/2018 10:15 AM, Jian-Hong Pan wrote:
> diff --git a/net/maclorawan/Kconfig b/net/maclorawan/Kconfig
> new file mode 100644
> index 000000000000..741992b059c6
> --- /dev/null
> +++ b/net/maclorawan/Kconfig
> @@ -0,0 +1,14 @@
> +config LORAWAN
> +	tristate "MAC layer of LoRaWAN Network support"
> +	select CRYPTO
> +	select CRYPTO_CMAC
> +	select CRYPTO_CBC
> +	select CRYPTO_AES
> +	---help---
> +	  LoRaWAN defines a low data rate, low power and long range wireless
> +	  wide area networks. It was designed to organise networks of sensors,
> +	  switches and actuators, etc automation devices.  It could operate as
> +	  multiple kilometers wide.

There are several things that I would change.  How about this instead?


	  LoRaWAN defines low data rate, low power and long range wireless
	  wide area networks. It was designed to organise networks of automation
	  devices, such as sensors, switches and actuators. It can operate
	  multiple kilometers wide.

> +
> +	  Say Y here to compile LoRaWAN support into the kernel or say M to
> +	  compile it as modules.


-- 
~Randy
