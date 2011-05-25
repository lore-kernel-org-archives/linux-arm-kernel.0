From: khilman@ti.com (Kevin Hilman)
Date: Wed, 25 May 2011 14:40:48 -0700
Subject: [PATCH 04/15] OMAP2PLUS: GPIO: Use flag to identify wkup dmn GPIO
In-Reply-To: <1306247094-25372-5-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:43 +0530")
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-5-git-send-email-tarun.kanti@ti.com>
Message-ID: <87ei3msbkv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> In omap3, save/restore context is implemented for GPIO
> banks 2-6 as GPIO bank1 is in wakeup domain. Instead
> of identifying bank's power domain by bank id, make use
> of a flag "loses_context" which is filled by
> pwrdm_can_ever_lose_context() during dev_init.
>
> For getting the powerdomain pointer, omap_hwmod_get_pwrdm()
> is used. omap_device_get_pwrdm() could not be used as the
> pwrdm information needs to be filled in pdata, whereas
> omap_device_get_pwrdm() could be used only after
> omap_device_build() call.
>
> Signed-off-by: Charulatha V <charu@ti.com>

Looks good.

Kevin
