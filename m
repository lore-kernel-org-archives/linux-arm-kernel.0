From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 05 Nov 2013 23:12:00 +0100
Subject: [PATCH] net: mv643xx_eth: Add missing phy_addr_set in DT mode
In-Reply-To: <1383611239-14556-1-git-send-email-jgunthorpe@obsidianresearch.com>
 (Jason Gunthorpe's message of "Mon, 4 Nov 2013 17:27:19 -0700")
References: <1383611239-14556-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <87sivacxcf.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Jason Gunthorpe <jgunthorpe@obsidianresearch.com> writes:

> Commit cc9d4598 'net: mv643xx_eth: use of_phy_connect if phy_node
> present' made the call to phy_scan optional, if the DT has a link to
> the phy node.
>
> However phy_scan has the side effect of calling phy_addr_set, which
> writes the phy MDIO address to the ethernet controller. If phy_addr_set
> is not called, and the bootloader has not set the correct address then
> the driver will fail to function.

Thanks *a lot* for fixing this one! I had the issue on my ReadyNAS 102
(Armada 370 based) which I had put on a todo list and temporarily
workarounded by including a 'ping whatever' call in my u-boot env in
order to force it to do the init. Without it, I was unable to properly
use the interface. With your fix, after multiple reboots to test it,
everything works as expected. So, FWIW: 

Tested-by: Arnaud Ebalard <arno@natisbad.org>

Cheers,

a+
