From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 Aug 2011 10:33:14 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <alpine.LFD.2.00.1108180005510.20358@xanadu.home>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1108180005510.20358@xanadu.home>
Message-ID: <20110818093313.GC19987@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2011 at 05:06:25AM +0100, Nicolas Pitre wrote:
> On Tue, 16 Aug 2011, Will Deacon wrote:
> 
> > Enabling CONFIG_DEBUG_LL (which is required for earlyprintk) hardwires
> > the debug UART address into the kernel, so that we can print before the
> > platform is initialised.
> > 
> > If the user inadvertently selects multiple platforms with DEBUG_LL
> > enabled, the UART address may not be correct and will likely cause the
> > kernel to hang in the very early stages of boot.
> > 
> > This patch, based on a skeleton from Russell, uses a Kconfig choice for
> > selecting the DEBUG_LL UART, therefore allowing the user to make a
> > choice about the supported platform when DEBUG_LL is enabled.
> > 
> > Cc: Linus Walleij <linus.walleij@stericsson.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> (ditto for the other 2 patches)

Thanks Nicolas. Hopefully some of the other platforms will start using this
once it's merged.

Will
