From: marex@denx.de (Marek Vasut)
Date: Thu, 22 Aug 2013 22:29:01 +0200
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <20130822195559.GU26118@sirena.org.uk>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <20130822193453.GB10038@ld-irv-0074.broadcom.com>
 <20130822195559.GU26118@sirena.org.uk>
Message-ID: <201308222229.01778.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark Brown,

> On Thu, Aug 22, 2013 at 12:34:53PM -0700, Brian Norris wrote:
> > On Mon, Aug 19, 2013 at 12:10:01PM +0800, Huang Shijie wrote:
> > > +- m25p,quad-read : Use the "quad read" opcode to read data from the
> > > chip instead +                   of the usual "read" opcode. This
> > > opcode is not supported by +                   all chips and support
> > > for it can not be detected at runtime. +                   Refer to
> > > your chips' datasheet to check if this is supported +                 
> > >  by your chip.
> > 
> > Why can't this be detected at runtime? We added a "no fast read" flag to
> > the device table, so why not "dual/quad mode supported"? And believe it
> > or not, not all m25p80 users have device tree. So it isn't very logical
> > to tie this support to device-tree only.
> 
> There needs to be some way of saying if the additional data lines are
> actually wired up or not; it could be a negative property (flagging if
> the lines are not present) but that runs the risk of breaking systems
> if a driver acquires the ability to support extra data lines but a
> system doesn't have it.
> 
> This should be a generic property for all quad devices to use, though,
> since the same thing applies everywhere.

Full ACK, "m25p,dual-read" and "m25p,quad-read" sound like a good prop names?

Best regards,
Marek Vasut
