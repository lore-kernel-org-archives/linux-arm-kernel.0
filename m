From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 11:52:09 +0000
Subject: [PATCH] TWD: enable one-shot mode
In-Reply-To: <4D2BE6C4.4040806@codeaurora.org>
References: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
	<4D2BE6C4.4040806@codeaurora.org>
Message-ID: <20110111115209.GA12781@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 09:12:36PM -0800, Stephen Boyd wrote:
> On 12/24/2010 11:18 AM, Russell King - ARM Linux wrote:
> > Allow one shot timer mode to be used with the TWD.  This allows
> > NOHZ mode to be used on SMP systems using the TWD localtimer.
> >
> > Tested on Versatile Express.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > Acks/Tested-by's would be appreciated, thanks.
> >
> 
> I see this patch was already tested and merged but can you elaborate on
> why this was done? From what I understand, NOHZ selects one-shot (like
> is done in this patch), so why don't the machines with a TWD choose NOHZ
> or high res timers?

You're right - so it's not actually required.  It should probably be
reverted, though it does no damage...
