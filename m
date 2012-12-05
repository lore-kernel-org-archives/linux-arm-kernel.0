From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 05 Dec 2012 11:47:39 +0100
Subject: [v2 PATCH 2/8] watchdog/at91sam9_wdt: Convert to use the watchdog
 framework
In-Reply-To: <1354671267-19277-3-git-send-email-wenyou.yang@atmel.com>
References: <1354671267-19277-1-git-send-email-wenyou.yang@atmel.com>
 <1354671267-19277-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <3976223.KImVV2lC5B@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,

On Wednesday 05 December 2012 09:34:21 Wenyou Yang wrote:
> According to the kernel document: convert_drivers_to_kernel_api.txt,
> remove the file_operations struct, miscdevice, and obsolete includes
> 
> Since the at91sam watchdog inherent characteristics, add the watchdog
> operations: at91wdt_start, at91wdt_stop and at91wdt_ping.
> 

[snip]

>  
> +static inline bool watchdog_is_open(struct watchdog_device *wddev)
> +{
> +	return test_bit(WDOG_DEV_OPEN, &wddev->status);
> +}

This helper should be moved to include/linux/watchdog.h as it can be useful
for other watchdog drivers as well. 
--
Florian
