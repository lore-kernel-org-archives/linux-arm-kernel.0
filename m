From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 4 Oct 2013 15:30:18 -0700
Subject: [PATCH v5 1/4] watchdog: at91sam9_wdt: better watchdog support
In-Reply-To: <1380871455-7324-2-git-send-email-b.brezillon@overkiz.com>
References: <1380871455-7324-1-git-send-email-b.brezillon@overkiz.com>
 <1380871455-7324-2-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20131004223018.GA3685@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 09:24:12AM +0200, Boris BREZILLON wrote:
> The at91sam9 watchdog timer can only be configured once, and the current
> implementation tries to configure it in a static way:
> - 2 seconds timeout
> - wdt restart every 500ms
> 
> If the timer has already been configured with different values, it returns an
> error and do not create any watchdog device.
> 
> This is not critical if the watchdog is disabled, but if it has been enabled with
> different timeout values it will lead to a SoC reset.
> 
> This patch series tries to address this issue by adapting the heartbeat value
> according the WDT timer config:
> - it first tries to configure the timer as requested.
> - if it fails it fallbacks to the current config, adapting its heartbeat timer
> to the needs
> 
> This patch series also move to a dynamically allocated at91wdt device instead
> of the static instance.
> 
> It adds a new at91 wdt type: software. This new type make use of the at91 wdt
> interrupt to trigger a software reboot.
> 
> Finally it adds several properties to the device tree bindings.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
