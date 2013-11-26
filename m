From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 26 Nov 2013 01:03:49 +0100
Subject: [PATCH v2] watchdog: s3c2410_wdt: Only register for cpufreq on
 ARM_S3C24XX_CPUFREQ
In-Reply-To: <1385422603-22684-1-git-send-email-dianders@chromium.org>
References: <1385420137-32725-1-git-send-email-dianders@chromium.org>
 <1385422603-22684-1-git-send-email-dianders@chromium.org>
Message-ID: <12609399.rlV8OtdFZt@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 of November 2013 15:36:43 Doug Anderson wrote:
> On modern SoCs the watchdog timer is parented on a clock that doesn't
> change every time we have a cpufreq change.  That means we don't need
> to constantly adjust the watchdog timer, so avoid registering for and
> dealing with cpufreq transitions unless we've actually got
> CONFIG_ARM_S3C24XX_CPUFREQ defined.
> 
> Note that this is more than just an optimization.  The s3c2410
> watchdog driver actually pats the watchdog on every CPU frequency
> change.  On modern systems these happen many times per second (even in
> a system where "nothing" is happening).  That effectively makes any
> userspace watchdog program useless (the watchdog is constantly patted
> by the kernel).  If we need ARM_S3C24XX_CPUFREQ defined on a
> multiplatform kernel we'll need to make sure that kernel supports
> common clock and change this to user common clock framework.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v2:
> - Use the updated config name.
> 
>  drivers/watchdog/s3c2410_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
