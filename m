From: khilman@ti.com (Kevin Hilman)
Date: Wed, 25 May 2011 16:30:49 -0700
Subject: [PATCH 14/15] OMAP: GPIO: Use memset for omap_gpio_reg_offs
In-Reply-To: <1306247094-25372-15-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:53 +0530")
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-15-git-send-email-tarun.kanti@ti.com>
Message-ID: <877h9el5na.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Use memset to fill omap_gpio_reg_offs structure with 0xFFFF
> instead of filling each and every undefined register offset
> separately with USHRT_MAX in a given OMAP SoC. This would ease
> while adding new register offsets in the future SoCs.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

This can be dropped in favor of using zero to indicate a non-existant
register offset.  Only the revision register needs a special case of
using USHRT_MAX since zero can be a valid offset for the revision
register.

Kevin
