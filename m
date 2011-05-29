From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 29 May 2011 10:24:32 +0100
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <20110527180625.GS24876@n2100.arm.linux.org.uk>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
	<C832F8F5D375BD43BFA11E82E0FE9FE00AFDABA5E2@EXDCVYMBSTM005.EQ1STM.local>
	<20110527150242.GB14035@e102109-lin.cambridge.arm.com>
	<20110527180625.GS24876@n2100.arm.linux.org.uk>
Message-ID: <20110529092429.GA9489@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 07:06:25PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 27, 2011 at 04:02:42PM +0100, Catalin Marinas wrote:
> > I think Arnd's point was that the writel_relaxed() variant may be even
> > more relaxed on other architectures than it is on ARM. I can't talk
> > about them.
> 
> Actually, writel_relaxed() doesn't exist outside ARM, it's not part of
> the IO specification.  That's why it shouldn't be used in generic drivers
> until it's become part of the IO specification _first_.

The read*_relaxed is provided by many other architectures. The
write*_relaxed seems to be provided by arm and sh only. But it is not
part of the IO specification. It should become part as this was the
suggested improvement during the barrier threads we had on linux-arch in
the past.  I can write a few simple patches and post them on linux-arch
for review.  I think the tricky part is getting an agreement with the
other architectures on how relaxed they can be.

-- 
Catalin
