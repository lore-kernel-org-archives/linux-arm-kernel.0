From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 31 Dec 2015 23:33:45 +0100 (CET)
Subject: [PATCH v2 RESEND 1/3] clocksource/vt8500: Use MIN_OSCR_DELTA
 from PXA
In-Reply-To: <1451584927-4051-2-git-send-email-v1ron@mail.ru>
References: <1451584927-4051-1-git-send-email-v1ron@mail.ru>
 <1451584927-4051-2-git-send-email-v1ron@mail.ru>
Message-ID: <alpine.DEB.2.11.1512312331580.28591@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Roman,

On Thu, 31 Dec 2015, Roman Volkov wrote:
> Since vt8500 and PXA timers are identical, use MIN_OSCR_DELTA from PXA,
> which is bigger than existing value. It is required to determine the
> minimum delay which hardware can generate.

Now that brings up the obvious question:

If the vt8500 and PXA timers are identical why has vt8500 it's own slightly
different implementation and does not use the PXA timer?

Thanks,

	tglx
