From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 24 Jan 2011 16:44:57 +0530
Subject: [PATCH 3/5] ARM: twd: Add context save restore support
In-Reply-To: <20110124110609.GJ16202@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
	<20110124110609.GJ16202@n2100.arm.linux.org.uk>
Message-ID: <c51db1b07546a34c74311392880d66de@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, January 24, 2011 4:36 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
> ccross at android.com; linus.ml.walleij at gmail.com; linux-
> omap at vger.kernel.org
> Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
>
> On Mon, Jan 24, 2011 at 02:21:17PM +0530, Santosh Shilimkar wrote:
> > In CPU low power state, local timer looses its register context.
> This
> > patch adds context save restore hooks which can be used by
> platforms
> > appropriately.
>
> I thought the whole point of CLOCK_EVT_FEAT_C3STOP was that the
> generic
> timer stuff wouldn't rely on it being kept alive?
>
> Hmm, it looks like we bypass the clockevents code by only setting
> the
> TWD load value at initialization time, not when we switch to
> periodic
> mode.  We really ought to rewrite it whenever we switch back to
> periodic
> mode.
>
Idea looks good though am not sure the one shot mode.

> I suspect fixing that means you won't need this save/restore
> support.
Will try it out.

Regards,
Santosh
