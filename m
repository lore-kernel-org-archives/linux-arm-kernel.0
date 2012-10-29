From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Oct 2012 10:52:28 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: move mailbox.h out of plat-omap headers
In-Reply-To: <1351530381-11459-2-git-send-email-omar.luna@linaro.org>
References: <1351530381-11459-1-git-send-email-omar.luna@linaro.org>
 <1351530381-11459-2-git-send-email-omar.luna@linaro.org>
Message-ID: <20121029175228.GD11908@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> --- /dev/null
> +++ b/include/linux/platform_data/omap_mailbox.h
> @@ -0,0 +1,105 @@

This file should only contain pure platform data needed
by the core omap code to pass to the mailbox driver.

The mailbox API header should be somewhere else,
like include/linux/mailbox/mailbox-omap.h or similar.

But shouldn't this all now be handled by using the
remoteproc framework?

Regards,

Tony
