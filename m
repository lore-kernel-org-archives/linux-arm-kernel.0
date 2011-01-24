From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 11:06:09 +0000
Subject: [PATCH 3/5] ARM: twd: Add context save restore support
In-Reply-To: <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110124110609.GJ16202@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 02:21:17PM +0530, Santosh Shilimkar wrote:
> In CPU low power state, local timer looses its register context. This
> patch adds context save restore hooks which can be used by platforms
> appropriately.

I thought the whole point of CLOCK_EVT_FEAT_C3STOP was that the generic
timer stuff wouldn't rely on it being kept alive?

Hmm, it looks like we bypass the clockevents code by only setting the
TWD load value at initialization time, not when we switch to periodic
mode.  We really ought to rewrite it whenever we switch back to periodic
mode.

I suspect fixing that means you won't need this save/restore support.
