From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 30 Aug 2011 22:52:42 +0800
Subject: [PATCH 1/3] ARM: cache-l2x0: make the reinitialization possible
In-Reply-To: <CAGsJ_4xavZXTa2Z+isORODjK_HoFpSJ5ZMRrd38metiZzYDBeA@mail.gmail.com>
References: <1314690017-17590-1-git-send-email-shawn.guo@linaro.org>
	<1314690017-17590-2-git-send-email-shawn.guo@linaro.org>
	<CAGsJ_4xavZXTa2Z+isORODjK_HoFpSJ5ZMRrd38metiZzYDBeA@mail.gmail.com>
Message-ID: <20110830145240.GA19359@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 10:08:59PM +0800, Barry Song wrote:
> 2011/8/30 Shawn Guo <shawn.guo@linaro.org>:
> > If ARM core gets powered off during suspend, L2 cache controller
> > has to be reinitialized by resume procedure.
> >
> > The patch removes __init annotation from a few initialization
> > functions to make the reinitialization possible. ?For example,
> > platform resume function can call l2x0_of_init() to get L2 cache
> > back to work.
> 
> i think it is good. and i have sent a similar patch before:
> 
> http://www.spinics.net/lists/arm-kernel/msg137372.html
> [PATCH v2 3/4] ARM: L2X0: move l2x0_init out of .init section
> 
Since prima2 supports DT, you may also want to call l2x0_of_init()
instead of l2x0_init().  l2x0_of_init() will parse configuration from
DT and sets up tag RAM control for you.

-- 
Regards,
Shawn
