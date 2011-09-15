From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Sep 2011 09:43:32 +0100
Subject: [PATCH v2 0/2] make reinitialization of ARM core components
	possible
In-Reply-To: <20110915015338.GF1488@S2100-06.ap.freescale.net>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<4E65B71E.6060307@ti.com>
	<20110912054140.GE1258@S2100-06.ap.freescale.net>
	<20110914190739.GE6267@n2100.arm.linux.org.uk>
	<20110915015338.GF1488@S2100-06.ap.freescale.net>
Message-ID: <20110915084332.GH6267@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 09:53:39AM +0800, Shawn Guo wrote:
> The re-init approach calls the exactly same function used for the
> initial init during resume.  So if this is a problem, it's the problem
> of initial init.  The initial init code should initialize the L2 into
> a known state with "values" rather than "mask + values" method.

That may not be possible - the kernel may have no knowledge of the correct
settings for the number of ways and cacheline size etc for the platform.
It may be that these settings have been configured by the secure monitor
rather than the boot loader.

I couldn't tell you what the correct settings would be for Versatile
Express for instance, and I bet that the correct settings are a function
of the FPGA images loaded onto the board.
