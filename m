From: horms@verge.net.au (Simon Horman)
Date: Thu, 4 Jan 2018 17:55:17 +0100
Subject: [PATCH] arm64: dts: renesas: r8a77995: move nodes which have no
 reg property out of bus
In-Reply-To: <20171220122442.9199-1-horms+renesas@verge.net.au>
References: <20171220122442.9199-1-horms+renesas@verge.net.au>
Message-ID: <20180104165517.za3o44n7ikfs4vgg@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 01:24:42PM +0100, Simon Horman wrote:
> Move pmu_a53 and timer nodes from soc node to root node.  The nodes that
> have been moved do not have any register properties and thus shouldn't be
> placed on the bus.
> 
> This problem is flagged by the compiler as follows:
> $ make W=1
> ...
> arch/arm64/boot/dts/renesas/r8a77995-draak.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> arch/arm64/boot/dts/renesas/r8a77995-draak.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied
