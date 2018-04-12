From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Apr 2018 07:39:32 -0700
Subject: [PATCH 11/14] gpio: omap: Restore power_mode configuration at
 resume time
In-Reply-To: <1523505239-16229-12-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-12-git-send-email-j-keerthy@ti.com>
Message-ID: <20180412143932.GA5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [180412 03:56]:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Commit 2dc983c565e0 ("gpio/omap: cleanup prepare_for_idle and
> resume_after_idle") introduces omap2_gpio_prepare_for_idle and
> omap2_gpio_resume_after_idle to properly configure gpios that are used
> as wake sources. When entering off mode, omap2_gpio_prepare_for_idle
> can set a flag indicating off-mode entry is desired, however once this
> flag is set it is never cleared, so any additional calls to this
> function, regardless of the mode, have this flag set.
> 
> This patch restores the pwr_mode flag to 0 in
> omap2_gpio_resume_after_idle to ensure the flag is not misconfigured
> during non off-mode operation.

Seems like this should be applied as a fix, can you please add
a proper Fixes tag?

Regards,

Tony
