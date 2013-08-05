From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 05 Aug 2013 08:43:22 -0700
Subject: [PATCH 4/4] ARM: OMAP2+: Sync hwmod state with the pm_runtime and
 omap_device state
In-Reply-To: <1374487277-26099-5-git-send-email-rnayak@ti.com> (Rajendra
 Nayak's message of "Mon, 22 Jul 2013 15:31:17 +0530")
References: <1374487277-26099-1-git-send-email-rnayak@ti.com>
 <1374487277-26099-5-git-send-email-rnayak@ti.com>
Message-ID: <87iozkkusl.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

> Some hwmods which are marked with HWMOD_INIT_NO_IDLE are left in enabled
> state post setup(). When a omap_device gets created for such hwmods
> make sure the omap_device and pm_runtime states are also in sync for such
> hwmods by doing a omap_device_enable() and pm_runtime_set_active() for the
> device.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

This looks like the right fix to me.

Acked-by: Kevin Hilman <khilman@linaro.org>
