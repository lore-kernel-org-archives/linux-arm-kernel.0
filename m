From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jul 2016 11:31:37 +0100
Subject: [PATCH 0/7] dmaengine:omap-dma: Linked List transfer for slave_sg
In-Reply-To: <20160714124242.7579-1-peter.ujfalusi@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
Message-ID: <20160718103137.GG5783@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2016 at 03:42:35PM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> The following series with the final patch will add support for sDMA Linked List
> transfer support.
> Linked List is supported by sDMA in OMAP3630+ (OMAP4/5, dra7 family).
> If the descriptor load feature is present we can create the descriptors for each
> SG beforehand and let sDMA to walk them through.
> This way the number of sDMA interrupts the kernel need to handle will drop
> dramatically.

I suggested this a few years ago, and I was told by TI that there was
no interest to implement this feature as it had very little performance
effect.  Do I take it that TI have changed their position on this
feature?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
