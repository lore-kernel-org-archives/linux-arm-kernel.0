From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 11:44:57 -0500
Subject: [PATCH v4 2/2] arm: mvebu: support for the new Armada XP
 development board(DB-MV784MP-GP)
In-Reply-To: <1359998469-28133-3-git-send-email-gregory.clement@free-electrons.com>
References: <1359998469-28133-1-git-send-email-gregory.clement@free-electrons.com>
 <1359998469-28133-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130216164457.GA23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 06:21:08PM +0100, Gregory CLEMENT wrote:
> This is the new Armada XP evaluation board from Marvell. It comes with
> a RS232 port over USB, a SATA link, an internal SSD, 4 Ethernet
> Gigabit links.
> 
> Support for USB (Host and device), SDIO, PCIe will be added as drivers
> when they become available for Armada XP in mainline.
> 
> Tested-by: Simon Guinot <simon.guinot@sequanux.org>
> Tested-by: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile         |    1 +
>  arch/arm/boot/dts/armada-xp-gp.dts |  101 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts

dammit.  I missed v4 and applied v3 of this patch.  The only difference
is the size of RAM (I applied 3GB, v4 has 4GB).  I'll go ahead and
apply v4 ATAG defconfig (patch #1 of v4) to mvebu/boards.  Then, we'll
do a follow-up patch to -rc1 to correct the RAM size.

This is too small a change be worth going through and redoing /boards
and /dt at this point.

Sorry about that.

thx,

Jason.
