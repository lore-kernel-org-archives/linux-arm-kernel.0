From: timur@tabi.org (Timur Tabi)
Date: Fri, 23 Oct 2015 10:37:49 -0500
Subject: [PATCH] Revert "serial: amba-pl011: fix incorrect integer size in
 pl011_fifo_to_tty()"
In-Reply-To: <20151023133403.GI4796@e103592.cambridge.arm.com>
References: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
 <20151023103056.GI4801@e103592.cambridge.arm.com>
 <562A297A.9030204@codeaurora.org>
 <20151023133403.GI4796@e103592.cambridge.arm.com>
Message-ID: <562A544D.7080506@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2015 08:34 AM, Dave P Martin wrote:
> Well, I'm not saying there's definitely no kernel bug, but I can't see
> how the patch should cause it.  It may be triggering a latent bug
> somewhere else in the driver than hasn't been biting us before, however.

Fair enough.

> !CREAD is the most obvious cause, so that should definitely be ruled
> out first.  If CREAD is clear, we need to figure out why...

So I tested this by booting to my console, and then typing in:

	stty -cread

and when I did that, the console ignored all input.

I do admit that since !CREAD has been ignored for so many reason, it 
could be that a lot of userspaces will suddenly have broken consoles.
