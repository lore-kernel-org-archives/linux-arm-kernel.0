From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Mar 2014 18:42:16 +0100
Subject: [PATCH 00/10] SMP support for Armada 375 and 38x
In-Reply-To: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1396012026-5997-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140328174216.GD22339@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 02:06:56PM +0100, Thomas Petazzoni wrote:
> Jason, Andrew, Gregory, Sebastian,
> 
> This patch series adds SMP support for the Armada 375 and 38x. Most of
> the patches are fairly straight-forward, but here is a short overview
> of what's going on:
> 
>  * Patches 1, 2, 3 make some preparatory clean-ups. Actually, patches
>    2 and 3 are not directly related to adding Armada 375 and 38x SMP
>    support, but they are related to the SMP support of Armada XP.
> 
>  * Patches 4, 5 and 6 add a few bits needed for the SMP support.
> 
>  * Patch 7 is adding the SMP support itself. Since both Armada 375 and
>    38x are Cortex-A9, their SMP logic is fairly similar, the only
>    difference being how to define the boot address of the secondary
>    CPU. Therefore, we've used a single smp_operations implementation.
> 
>  * Patch 8 add a workaround for a SMP booting bug affecting Armada 375
>    Z1 stepping. It requires using the Crypto SRAM loaded with a few
>    instructions of code as a replacement of the BootROM for booting
>    the secondary processor. For now, the workaround is unconditionally
>    applied on all Armada 375 platforms, but as soon as we get access
>    to more recent platforms, we'll add a mvebu-soc-id based test to
>    only enable the workaround if needed.
> 
>  * Patch 9 and 10 add the necessary Device Tree bits to enable SMP on
>    Armada 375 and 38x.

Not my area of expertise, but it all looks O.K. The only comment,
which i suspect Jason will say sometime soon, is that it would be nice
if the workaround was triggered on the stepping, i.e. the same comment
he made before for another similar workaround.

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
