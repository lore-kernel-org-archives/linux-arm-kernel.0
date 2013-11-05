From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 4 Nov 2013 19:36:35 -0500
Subject: [PATCH] net: mv643xx_eth: Add missing phy_addr_set in DT mode
In-Reply-To: <1383611239-14556-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1383611239-14556-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <20131105003635.GG3060@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Mon, Nov 04, 2013 at 05:27:19PM -0700, Jason Gunthorpe wrote:
> Commit cc9d4598 'net: mv643xx_eth: use of_phy_connect if phy_node

fyi: set core.abbrev = 12 in your git config, according to Linus, 7/8
was a bad decision...

> present' made the call to phy_scan optional, if the DT has a link to
> the phy node.
> 
> However phy_scan has the side effect of calling phy_addr_set, which
> writes the phy MDIO address to the ethernet controller. If phy_addr_set
> is not called, and the bootloader has not set the correct address then
> the driver will fail to function.
> 
> Tested on Kirkwood.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Fixes: cc9d459894b0 "net: mv643xx_eth: use of_phy_connect if phy_node present"
Acked-by: Jason Cooper <jason@lakedaemon.net>

And it should be suitable for v3.11+

thx,

Jason.
