From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Aug 2012 20:53:08 +0100
Subject: [PATCH 1/2] net: davinci_mdio: enable and disable clock
In-Reply-To: <1343936616-29318-1-git-send-email-zonque@gmail.com>
References: <1343936616-29318-1-git-send-email-zonque@gmail.com>
Message-ID: <20120802195308.GZ6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 09:43:35PM +0200, Daniel Mack wrote:
> Make the driver control the device clocks. Appearantly, the Davinci
> platform probes this driver with the clock all powered up, but on OMAP,
> this isn't the case.

Hmm, this looks like it could do with improvement, especially as we're
moving everything over to a common clk API.

1. This driver could do with clk_prepare()/clk_unprepare() calls.
2. This driver should not be making the assumption that NULL means
   it can avoid clk_* calls.  It should instead be using
	if (!IS_ERR(clk))

Thanks.
