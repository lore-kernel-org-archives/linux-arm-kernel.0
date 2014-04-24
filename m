From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 11:34:55 +0100
Subject: [PATCH 2/4] ARM: S3C24XX: trim down debug uart handling
In-Reply-To: <1410234.AYxfyBcLWB@phil>
References: <1544889.hRy2JpKRQe@phil> <1410234.AYxfyBcLWB@phil>
Message-ID: <20140424103455.GJ26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 12:24:31PM +0200, Heiko St?bner wrote:
> +choice
> +	prompt "S3C24XX low-level debugging port type"
> +	depends on DEBUG_LL && ARCH_S3C24XX
> +
> +	config DEBUG_S3C24XX_UART_S3C2440
> +		bool "S3C2440 uart type"
> +		help
> +		  Select this if you're debugging S3C2416, S3C2440, S3C2442,
> +		  S3C2443 or S3C2450 SoCs.
> +
> +	config DEBUG_S3C24XX_UART_S3C2410
> +		bool "S3C2410 uart type"
> +		help
> +		  Select this if you're debugging S3C2410 or S3C2412 SoCs.
> +endchoice

Why does this need to be a separate choice statement?  What's special
about S3C24XX?  Is there something wrong with the main choice statement
just above this where everyone else lists their debugging UART?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
