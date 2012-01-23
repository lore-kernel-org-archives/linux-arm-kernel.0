From: khilman@ti.com (Kevin Hilman)
Date: Mon, 23 Jan 2012 15:38:50 -0800
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <1326983304-14619-2-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Thu, 19 Jan 2012 19:58:22 +0530")
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <1326983304-14619-2-git-send-email-hvaibhav@ti.com>
Message-ID: <87mx9ej8fp.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> OMAP device has 32k-sync timer which is currently used as a
> clocksource in the kernel (omap2plus_defconfig).
> The current implementation uses compile time selection between
> gp-timer and 32k-sync timer, which breaks multi-omap build for
> the devices like AM33xx, where 32k-sync timer is not available.
>
> So use hwmod database lookup mechanism, through which at run-time
> we can identify availability of 32k-sync timer on the device,
> else fall back to gp-timer.

With the runtime detection & fallback, I suggest also removing the
Kconfig choice between the two as well.

Kevin
