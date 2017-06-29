From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 29 Jun 2017 15:10:59 +0100
Subject: [PATCHv5] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <20170627120555.dwcrd52dfstookmh@linutronix.de>
References: <1494944285-12152-1-git-send-email-mark.rutland@arm.com>
 <20170517160530.GB18716@e104818-lin.cambridge.arm.com>
 <20170627120555.dwcrd52dfstookmh@linutronix.de>
Message-ID: <20170629141058.GG11040@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 27, 2017 at 02:05:55PM +0200, Sebastian Andrzej Siewior wrote:
> On 2017-05-17 17:05:31 [+0100], Catalin Marinas wrote:
> > > Catalin, can you take this as a fix for v4.12?
> > 
> > I queued it for 4.12-rc2. Thanks.
> 
> I backported a few patches into v4.11-RT and the backtrace popped up
> (which is fixed by this patch). The problem existed before it has been
> made visible. Do you intend to push this patch stable?

I wasn't planning to.

This was fairly invasive (so there'd be a number of conflicts to fix
up), and we weren't seeing issues in practice for !RT kernels.

If this is causing ap roblem in practice for !RT, I'd be happy to.

Thanks,
Mark.
