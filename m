From: khilman@ti.com (Kevin Hilman)
Date: Thu, 26 May 2011 10:23:33 -0700
Subject: [PATCH 1/3] OMAP: change get_context_loss_count ret value to int
In-Reply-To: <1306428307-1360-2-git-send-email-tomi.valkeinen@ti.com> (Tomi
	Valkeinen's message of "Thu, 26 May 2011 19:45:05 +0300")
References: <1306428307-1360-1-git-send-email-tomi.valkeinen@ti.com>
	<1306428307-1360-2-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <871uzlgyui.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> get_context_loss_count functions return context loss count as u32, and
> zero means an error. However, zero is also returned when context has
> never been lost and could also be returned when the context loss count
> has wrapped and goes to zero.
>
> Change the functions to return an int, with negative value meaning an
> error.
>
> OMAP HSMMC code uses omap_pm_get_dev_context_loss_count(), but as the
> hsmmc code handles the returned value as an int, with negative value
> meaning an error, this patch actually fixes hsmmc code also.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>
