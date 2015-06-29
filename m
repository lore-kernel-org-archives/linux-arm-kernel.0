From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 29 Jun 2015 11:24:36 +0200 (CEST)
Subject: [RESEND PATCH v3] clocksource: exynos_mct: fix for sleeping in
 atomic ctx handling cpu hotplug notif.
In-Reply-To: <55910DA6.4070404@linaro.org>
References: <1426151496-5509-1-git-send-email-d.eppel@samsung.com>
 <1435324984-7328-1-git-send-email-d.eppel@samsung.com>
 <55910DA6.4070404@linaro.org>
Message-ID: <alpine.DEB.2.11.1506291123320.4037@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Jun 2015, Daniel Lezcano wrote:

> On 06/26/2015 03:23 PM, Damian Eppel wrote:
> > This is to fix an issue of sleeping in atomic context when processing
> > hotplug notifications in Exynos MCT(Multi-Core Timer).
> > The issue was reproducible on Exynos 3250 (Rinato board) and Exynos 5420
> > (Arndale Octa board).
> > 
> > Whilst testing cpu hotplug events on kernel configured with DEBUG_PREEMPT
> > and DEBUG_ATOMIC_SLEEP we get following BUG message, caused by calling
> > request_irq() and free_irq() in the context of hotplug notification
> > (which is in this case atomic context).
> 
> Applied as a 4.2 fix.
> 
> Should it be tagged stable@ ?

I have that one queued in tip/timers/urgent already. Please check my
branches before picking up stuff.

Thanks,

	tglx
