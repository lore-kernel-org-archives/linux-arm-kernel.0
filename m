From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 18 Apr 2012 00:09:05 +0300
Subject: [PATCH v2 3/8] ARM: LPC32xx: clock.c update
In-Reply-To: <1334682507-15055-4-git-send-email-stigge@antcom.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <1334682507-15055-4-git-send-email-stigge@antcom.de>
Message-ID: <20120417210905.GJ6498@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 07:08:22PM +0200, Roland Stigge wrote:
> Besides switching to the default macro CLKDEV_INIT() for clock registration,
> this patch actually updates the clock registrations of pl08xdmac.
> 

When there is a cleanup and a new feature added in the same patch,
it makes it hard to read...  :/  So when we update pl08xdmac:

-       CLKDEV_INIT(NULL, "clk_dmac", &clk_dma),
+       CLKDEV_INIT("pl08xdmac", NULL, &clk_dma),

What does that actually do?  Is it a bug fix?

regards,
dan carpenter
