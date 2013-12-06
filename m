From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 6 Dec 2013 13:28:48 -0800
Subject: [PATCH v3] watchdog: s3c2410_wdt: Report when the watchdog reset
 the system
In-Reply-To: <1386364088-6220-1-git-send-email-dianders@chromium.org>
References: <1386267329-9941-2-git-send-email-dianders@chromium.org>
 <1386364088-6220-1-git-send-email-dianders@chromium.org>
Message-ID: <20131206212848.GA12283@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 01:08:07PM -0800, Doug Anderson wrote:
> A good watchdog driver is supposed to report when it was responsible
> for resetting the system.  Implement this for the s3c2410, at least on
> exynos5250 and exynos5420 where we already have a pointer to the PMU
> registers to read the information.
> 
> Note that exynos4 SoCs also provide the reset status, but providing
> that is left as an exercise for future changes and is not plumbed up
> in this patch series.  Also note the exynos4 SoCs don't appear to need
> any PMU config, which is why this patch separates the concepts of
> having PMU Registers vs. needing PMU Config.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
