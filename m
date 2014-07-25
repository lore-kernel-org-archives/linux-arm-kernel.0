From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 25 Jul 2014 22:05:47 +0200
Subject: [PATCH] ARM: mvebu: armada xp: Generalize use of i2c quirk
In-Reply-To: <1406308951-14612-1-git-send-email-andrew@lunn.ch>
References: <1406308951-14612-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140725220547.0ab31cb4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri, 25 Jul 2014 19:22:31 +0200, Andrew Lunn wrote:
> A second product has come to light which makes use of the A0 stepping
> of the Armada XP SoC. A0 stepping has a hardware bug in the i2c core
> meaning that hardware offload does not work, resulting in the kernel
> failing to boot. The quirk detects that the kernel is running on an A0
> stepping SoC and disables the use of hardware offload.
> 
> Currently the quirk is only enabled for PlatHome Openblocks AX3. The
> AX3 has been produced with both A0 and B1 stepping SoCs. The second
> product is the Lenovo Iomega IX4-300d. It seems likely that this
> device will also swap from A0 to B1 SoC sometime during its life.
> 
> If there are two products using A0, it seems likely there are more
> products with A0. Also, since the number of A0 SoCs is limited, these
> products are also likely to transition to B1. Hence detecting at run
> time is the safest option. So enable the quirk for all Armada XP
> boards.
> 
> Tested on an AX3 with A0 stepping.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Arnd's solution doesn't work, because it doesn't fix at all the problem
for the new Lenovo platform or any other new platform.

Only minor nit: s/B1/B0/ in the commit log.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
