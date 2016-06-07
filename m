From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 7 Jun 2016 06:22:35 -0700
Subject: [PATCH] watchdog: sirf: fix __iomem * warnings
In-Reply-To: <1465300387-20629-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465300387-20629-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5756CA9B.8090200@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2016 04:53 AM, Ben Dooks wrote:
> Fix the following warnings from sparse due to casting to/from an __iomem
> annotated variable:
>
> drivers/watchdog/sirfsoc_wdt.c:48:18: warning: incorrect type in assignment (different address spaces)
> drivers/watchdog/sirfsoc_wdt.c:48:18:    expected void [noderef] <asn:2>*wdt_base
> drivers/watchdog/sirfsoc_wdt.c:48:18:    got void *
> drivers/watchdog/sirfsoc_wdt.c:64:18: warning: incorrect type in assignment (different address spaces)
> drivers/watchdog/sirfsoc_wdt.c:64:18:    expected void [noderef] <asn:2>*wdt_base
> drivers/watchdog/sirfsoc_wdt.c:64:18:    got void *
> drivers/watchdog/sirfsoc_wdt.c:82:54: warning: incorrect type in initializer (different address spaces)
> drivers/watchdog/sirfsoc_wdt.c:82:54:    expected void [noderef] <asn:2>*wdt_base
> drivers/watchdog/sirfsoc_wdt.c:82:54:    got void *
> drivers/watchdog/sirfsoc_wdt.c:99:54: warning: incorrect type in initializer (different address spaces)
> drivers/watchdog/sirfsoc_wdt.c:99:54:    expected void [noderef] <asn:2>*wdt_base
> drivers/watchdog/sirfsoc_wdt.c:99:54:    got void *
> drivers/watchdog/sirfsoc_wdt.c:153:44: warning: incorrect type in argument 2 (different address spaces)
> drivers/watchdog/sirfsoc_wdt.c:153:44:    expected void *data
> drivers/watchdog/sirfsoc_wdt.c:153:44:    got void [noderef] <asn:2>*[assigned] base
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
