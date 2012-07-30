From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jul 2012 08:30:20 +0800
Subject: [PATCH] ARM: disable interrupt before spinning endlessly
In-Reply-To: <20120729212216.GA11423@n2100.arm.linux.org.uk>
References: <1341824988-18615-1-git-send-email-shawn.guo@linaro.org>
 <20120729212216.GA11423@n2100.arm.linux.org.uk>
Message-ID: <20120730003018.GA30774@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 29, 2012 at 10:22:16PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 09, 2012 at 05:09:48PM +0800, Shawn Guo wrote:
> > The CPU will endlessly spin at the end of machine_halt and
> > machine_restart calls.  However, this will lead to a soft lockup
> > warning after about 20 seconds, if CONFIG_LOCKUP_DETECTOR is enabled,
> > as system timer is still alive.
> > 
> > Disable interrupt before going to spin endlessly, so that the lockup
> > warning will never be seen.
> > 
> > Reported-by: Marek Vasut <marex@denx.de>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> 
> Should this also be Cc'd to stable when it's committed?

Yes, I forgot it.

I assume you will take care of it when you commit it to your tree.
Otherwise, please let me know and I will resubmit the patch.

-- 
Regards,
Shawn
