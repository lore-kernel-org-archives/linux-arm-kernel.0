From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 09:57:31 -0500
Subject: [PATCH 0/2] Remove two redundent clk aliases
In-Reply-To: <1357851669-25669-1-git-send-email-andrew@lunn.ch>
References: <1357851669-25669-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130123145731.GS1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 10:01:07PM +0100, Andrew Lunn wrote:
> Both USB and MDIO are now instantiated using DT and these DT nodes
> have clocks properties. Remove the now redundant clkdev aliases.
> 
> The first patch has no dependencies.
> 
> The second patch is dependent on the SDIO patchset "Device Tree
> binding for the mvsdio driver" by Thomas Petazzoni.
> 
> 
> Andrew Lunn (2):
>   ARM: Kirkwood: Remove redundent USB clock alias
>   ARM: Kirkwood: Remove redundent SDIO clock alias
> 
>  arch/arm/mach-kirkwood/board-dt.c |    9 ---------
>  1 file changed, 9 deletions(-)

Both applied to mvebu/boards.  Normally, I would put this in
mvebu/cleanup.  However, the dependency on mvebu/drivers (mvsdio
changes) meant putting it in boards removed any circular dependencies.

thx,

Jason.
