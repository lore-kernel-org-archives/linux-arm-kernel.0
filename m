From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 15 Oct 2014 11:25:46 -0400
Subject: [Patch V2 1/2] ARM: mvebu: armada xp: Generalize use of i2c quirk
In-Reply-To: <1406395238-29758-2-git-send-email-andrew@lunn.ch>
References: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
 <1406395238-29758-2-git-send-email-andrew@lunn.ch>
Message-ID: <20141015152546.GD17447@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Sat, Jul 26, 2014 at 07:20:37PM +0200, Andrew Lunn wrote:
> A second product has come to light which makes use of the A0 stepping
> of the Armada XP SoC. A0 stepping has a hardware bug in the i2c core
> meaning that hardware offload does not work, resulting in the kernel
> failing to boot. The quirk detects that the kernel is running on an A0
> stepping SoC and disables the use of hardware offload.
> 
> Currently the quirk is only enabled for PlatHome Openblocks AX3. The
> AX3 has been produced with both A0 and B0 stepping SoCs. The second
> product is the Lenovo Iomega IX4-300d. It seems likely that this
> device will also swap from A0 to B0 SoC sometime during its life.
> 
> If there are two products using A0, it seems likely there are more
> products with A0. Also, since the number of A0 SoCs is limited, these
> products are also likely to transition to B0. Hence detecting at run
> time is the safest option. So enable the quirk for all Armada XP
> boards.
> 
> Tested on an AX3 with A0 stepping.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> 
> V2:
> Added two Acked-by:
> s/B1/B0
> ---
>  arch/arm/mach-mvebu/board-v7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/fixes and Cc'd to stable for v3.12+

thx,

Jason.
