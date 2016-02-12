From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Feb 2016 14:16:54 +0000
Subject: [PATCH] ARM: imx: Do L2 errata only if the L2 cache isn't enabled
In-Reply-To: <1455261093-11849-1-git-send-email-dirk.behme@de.bosch.com>
References: <1455261093-11849-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20160212141654.GA10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 08:11:33AM +0100, Dirk Behme wrote:
> All the generic L2 cache handling code is encapsulated by a
> check if the L2 cache is enabled. If it's enabled already, the code
> is skipped.
> 
> For the i.MX6 specific L2 cache handling we missed this check.
> Add it.

What's the reasoning behind this?  The prefetch register is writable
while the L2 cache is enabled, unlike the auxiliary control register.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
