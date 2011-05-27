From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 May 2011 19:06:25 +0100
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <20110527150242.GB14035@e102109-lin.cambridge.arm.com>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<BANLkTimoRbokF4pnfMOf5WkPK+TyrHWwDg@mail.gmail.com>
	<C832F8F5D375BD43BFA11E82E0FE9FE00AFDABA5E2@EXDCVYMBSTM005.EQ1STM.local>
	<20110527150242.GB14035@e102109-lin.cambridge.arm.com>
Message-ID: <20110527180625.GS24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 04:02:42PM +0100, Catalin Marinas wrote:
> I think Arnd's point was that the writel_relaxed() variant may be even
> more relaxed on other architectures than it is on ARM. I can't talk
> about them.

Actually, writel_relaxed() doesn't exist outside ARM, it's not part of
the IO specification.  That's why it shouldn't be used in generic drivers
until it's become part of the IO specification _first_.
