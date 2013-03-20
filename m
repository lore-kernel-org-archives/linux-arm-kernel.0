From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 20 Mar 2013 14:50:06 -0700
Subject: [PATCH] rtc: rtc-at91rm9200: use a variable for storing IMR
In-Reply-To: <1363369032-12639-1-git-send-email-nicolas.ferre@atmel.com>
References: <1363369032-12639-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20130320145006.f1431c1528325ff93a298790@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Mar 2013 18:37:12 +0100 Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> On some revisions of AT91 SoCs, the RTC IMR register is not working.
> Instead of elaborating a workaround for that specific SoC or IP version,
> we simply use a software variable to store the Interrupt Mask Register and
> modify it for each enabling/disabling of an interrupt. The overhead of this
> is negligible anyway.

This description doesn't really allow me or others to work out whether
the fix should be included in 3.9 or backported into earlier kernels.

So please, when fixing a bug do include a full description of the
user-visible effects of that bug.  And your opinion regarding the
-mainline and -stable decision is always useful.
