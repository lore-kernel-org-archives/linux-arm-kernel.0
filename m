From: khilman@ti.com (Kevin Hilman)
Date: Tue, 20 Mar 2012 17:10:52 -0700
Subject: [PATCH v8 0/8] Consolidate cpuidle functionality
In-Reply-To: <1332274969-15782-1-git-send-email-rob.lee@linaro.org> (Robert
 Lee's message of "Tue, 20 Mar 2012 15:22:41 -0500")
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
Message-ID: <87wr6evmnn.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Robert Lee <rob.lee@linaro.org> writes:

> This patch series moves various functionality duplicated in platform 
> cpuidle drivers to the core cpuidle driver. Also, the platform irq
> disabling was removed as it appears that all calls into 
> cpuidle_call_idle will have already called local_irq_disable().
>
> These changes have been pulled into linux-next.
>
> Len, Andrew, can a request be made for Linus to pull these changes?
>
> Acked-by: Jean Pihet<j-pihet@ti.com>  (v6)
> Tested-by: Jean Pihet<j-pihet@ti.com>  (v6, omap3)
> Tested-by: Amit Daniel<amit.kachhap@linaro.org>  (v6, Exynos4)
> Tested-by: Robert Lee<rob.lee@linaro.org>  (imx51, imx6q)

Note that there's a space missing between the name and email in these
tags (and for Deepthi's below also.)  That seems to exist in all the
patches.

> Reviewed-by: Kevin Hilman <khilman@ti.com>

For my Reviewed-by, it only applies to the core code and the OMAP
changes.  I haven't reviewed the other platform-specific drivers.  I
believe the same applies to Jean Pihet who works with me on OMAP.

> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Deepthi Dharwar<deepthi@linux.vnet.ibm.com> (core cpuidle only)

Looks like you never heard from anyone actively working on at91,
shmobile, kirwood or davinci.

I'm not sure we should merge those platform-specific changes without an
ack from those platform maintainers.

For 3.4, maybe we should just merge the core code and the platforms that
have been reviewed/ack'd, and for 3.5, spent some time nagging the other
platform maintainers to review and test.

Kevin
