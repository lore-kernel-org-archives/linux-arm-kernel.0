From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Jul 2013 16:08:27 +0100
Subject: [PATCH 1/2] dma: mv_xor: use readl/writel instead of
 __raw_{readl, writel}
In-Reply-To: <1375110310-26276-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375110310-26276-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375110310-26276-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130729150827.GL24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 05:05:09PM +0200, Thomas Petazzoni wrote:
> In order to support big-endian execution, the mv_xor driver is changed
> to use thhe readl() and writel() accessors that properly convert from
> the CPU endianess to the device endianess (which in the case of
> Marvell XOR hardware is always little-endian).

Is it necessary that all these be barrier-ied IO operations?
