From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Aug 2015 13:49:24 +0100
Subject: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
In-Reply-To: <201508241303.52066.marex@denx.de>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <bf368fc101f38db231131b69eff0863210f2b01c.1440410236.git.cyrille.pitchen@atmel.com>
 <201508241303.52066.marex@denx.de>
Message-ID: <20150824124924.GZ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 01:03:51PM +0200, Marek Vasut wrote:
> These are functions, not macros :)
> 
> btw is there any reason for these ? I'd say, just put the read*() and
> write*() functions directly into the code and be done with it, it is
> much less confusing.
> 
> Also, why do you use the _relaxed() versions of the functions ?

Now that the _relaxed() accessors are available throughout the kernel,
everyone should be using the _relaxed() versions unless they need the
properties of the non-relaxed versions.  Remember that the non-relaxed
versions are rather expensive on ARM due to the need to go all the way
out to the L2 cache - it at least doubles the number of accesses for
every read*/write*().

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
