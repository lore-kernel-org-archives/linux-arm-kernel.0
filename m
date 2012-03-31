From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 31 Mar 2012 14:12:40 -0400
Subject: [PATCH V4 0/3] ARM: Kirkwood: Convert DNS-325 & DNS-320 to
 access nand via devicetree (was: Add support for DNS-320 and DNS-325 using
 devicetree)
In-Reply-To: <1333201985-2222-1-git-send-email-jm@lentin.co.uk>
References: <1333201985-2222-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20120331181240.GA817@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 02:53:02PM +0100, Jamie Lentin wrote:
> Right, I've stopped being lazy and researched what the various properties
> contain and documented them.
> 
> In the process I noticed that all other drivers have bank-width in bytes,
> so I changed orion_nand to match. If using orion_nand without devicetree,
> the width property is still in bits though. Hopefully this isn't considered too
> bad? They have different names at least.
> 
> I've left out everything that has been merged into either Grant or Jason's
> tree. Hopefully this was a useful thing to do.
> 
> Thanks again to everyone reviewing.
> 
> Changes since v3: Add support for DNS-320 and DNS-325 using devicetree
> * Remove patches that are already merged
> * Add documentation on orion_nand devicetree bindings
> * Convert bank-width to be in bytes to match other properties
> * Make defaults more explicit
> 
> Changes since v2: Add support for DNS-320 and DNS-325 using devicetree
> * Split patches further, separating orion_nand and kirkwood changes
> * dts renames: "bank-width", not "width". "okay", not "ok"
> * Separate documentation out into separate patch, add references to
>   partition.txt to all mtd bindings.
>   
> Changes since v1: Add support for DNS-320 and DNS-325 using devicetree
> * Rebase against kirkwood_dt_for_3.4, removing premature devicetree ports.
> * Move additions into a separate board-dnskw.c. It could be separated further
>   into a board-dns320.c and board-dns325.c but it probably isn't worth it.
> * s/marvell,/mrvl,/g
> * Include an example dtb partition in documentation
> * Copy structure of serial nodes to allow common options for NAND to be set
>   in kirkwood.dtsi
> * Simplifications in orion-nand.c
> 
> Jamie Lentin (3):
>   mtd: Add orion_nand devicetree bindings
>   kirkwood: Allow nand to be configured via. devicetree
>   ARM: kirkwood: Define DNS-320/DNS-325 NAND in fdt
> 
>  .../devicetree/bindings/mtd/orion-nand.txt         |   50 ++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-dns320.dts              |   35 ++++++++++++++
>  arch/arm/boot/dts/kirkwood-dns325.dts              |   35 ++++++++++++++
>  arch/arm/boot/dts/kirkwood.dtsi                    |   15 ++++++-
>  arch/arm/mach-kirkwood/board-dnskw.c               |   31 ------------
>  arch/arm/mach-kirkwood/common.c                    |   12 +++++
>  drivers/mtd/nand/orion_nand.c                      |   41 +++++++++++++++-
>  7 files changed, 185 insertions(+), 34 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/orion-nand.txt

Looks good, I'll let it sit a few days to catch any other comments.

For the whole series:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
