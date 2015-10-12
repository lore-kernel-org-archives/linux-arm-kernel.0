From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 12 Oct 2015 12:07:06 +0200
Subject: [PATCH 3/6] watchdog: at91sam9: rename heartbeats into timeout
 where necessary
In-Reply-To: <1444340074-15437-4-git-send-email-sylvain.rochet@finsecur.com>
References: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
 <1444340074-15437-4-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20151012100706.GA3088@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 11:34:31PM +0200, Sylvain Rochet wrote:
> 
> @@ -344,7 +342,7 @@ static int __init at91wdt_probe(struct platform_device *pdev)
>  	wdt->wdd.parent = &pdev->dev;
>  	wdt->wdd.info = &at91_wdt_info;
>  	wdt->wdd.ops = &at91_wdt_ops;
> -	wdt->wdd.timeout = WDT_HEARTBEAT;
> +	wdt->wdd.timeout = wdt_timeout;

This wasn't a good idea, if wdt_timeout is set using a module parameter 
to a wrong value we end up using this wrong value. Setting the default 
to a valid hardwired value and checking if the proposed value is valid 
using watchdog_init_timeout is obviously the way to go. I will rework 
that in v2.

Sylvain
