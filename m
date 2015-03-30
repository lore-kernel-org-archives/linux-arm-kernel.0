From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 30 Mar 2015 17:09:35 +0100
Subject: [PATCH v4 2/2] serial/amba-pl011: Refactor and simplify TX FIFO
 handling
In-Reply-To: <20150330162811.3673482b@north>
References: <1427468371-11915-1-git-send-email-Dave.Martin@arm.com>
 <1427468371-11915-3-git-send-email-Dave.Martin@arm.com>
 <20150330162811.3673482b@north>
Message-ID: <20150330160934.GE22949@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 04:28:11PM +0200, Jakub Kicinski wrote:
> On Fri, 27 Mar 2015 14:59:31 +0000, Dave Martin wrote:
> > To this end, the TX softirq mechanism is removed and instead

[...]

> > pl011_start_tx() will now simply stuff the FIFO until full
> > (guaranteeing future TX IRQs), or until there are no more chars
> > to write (in which case we don't care whether an IRQ happens).
> > 
> > [1] Thanks to Jakub Kicinski for his input and similar patch.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Signed-off-by: Jakub Kicinski <kubakici@wp.pl>

Agreed, shoulda had that (sorry!)

Greg, can you add Jakub's S-o-B when applying, or do you want me to
repost?

Cheers
---Dave
