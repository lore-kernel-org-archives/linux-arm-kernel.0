From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Nov 2014 20:56:06 -0500
Subject: [PATCHv3 0/5] ARM: mvebu: no I/O coherency on non-SMP and
 related updates
In-Reply-To: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141122015606.GN22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Thu, Nov 13, 2014 at 10:38:55AM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> This series makes a number of updates to the I/O coherency code of
> Marvell EBU platforms.
> 
> Changes since v2:
> 
>  - Drop patch "ARM: mvebu: add missing of_node_put() call in
>    coherency.c" since it was merged.
> 
>  - Update "make the coherency_ll.S functions work with no coherency
>    fabric" to use "reteq <reg>" instead of "moveq pc, <reg>", as
>    suggested by Gr?gory Clement.
> 
>  - Update the comment in "disable I/O coherency on non-SMP situations
>    on Armada 370/375/38x/XP" to give more details about what would be
>    needed to get HW I/O coherency working on Armada 370, as suggested
>    by Jason Cooper.
> 
>  - Added Acked-by from Gr?gory Clement as appropriate.
> 
>  - Added one patch to drop the Armada 375 Z1 workaround for I/O
>    coherency, which removes a significant chunk of code from
>    coherency.c.
> 
>  - Added two patches doing minor cleanup/updates to coherency.c
> 
> Changes since v1:
> 
>  - Rebased on top of v3.18-rc2.
>  - Added some Fixes:/Cc: tags on the last patch to get it merged into
>    the stable tree, as it fixes a real DT reference count leak.
> 
> Best regards,
> 
> Thomas Petazzoni
> 
> Thomas Petazzoni (5):
>   ARM: mvebu: make the coherency_ll.S functions work with no coherency
>     fabric
>   ARM: mvebu: disable I/O coherency on non-SMP situations on Armada
>     370/375/38x/XP
>   ARM: mvebu: remove unused register offset definition
>   ARM: mvebu: remove Armada 375 Z1 workaround for I/O coherency
>   ARM: mvebu: update comments in coherency.c
> 
>  arch/arm/mach-mvebu/coherency.c    | 220 ++++++-------------------------------
>  arch/arm/mach-mvebu/coherency_ll.S |  21 +++-
>  2 files changed, 55 insertions(+), 186 deletions(-)

Whole series applied to mvebu/soc with a dependency on mvebu/fixes.

thx,

Jason.
