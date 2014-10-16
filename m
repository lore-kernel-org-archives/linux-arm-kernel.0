From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 16 Oct 2014 14:53:25 +0200
Subject: [PATCH 0/5] Berlin BG2 AHCI and SATA PHY
In-Reply-To: <1413042073-14253-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413042073-14253-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20141016125325.GA17079@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Sat, Oct 11, 2014 at 05:41:08PM +0200, Sebastian Hesselbarth wrote:
> This patch set catches up with latest Berlin improvements provided
> by Antoine - in particular SATA PHY support and AHCI generic for
> Berlin BG2.
> 
> Marvell BSP code for BG2 suggests more differences between the two
> PHY revisions found on BG2 and BG2Q, but the only important one seems
> to be the PHY_BASE used in AHCI vendor-specific registers. I also
> confirmed that power_off does indeed power off the PHY on BG2, too
> (It wasn't very clear in BSP code).
> 
> Anyway, I have tested this on BG2-based Sony NSZ-GS7 and attached
> SATA HDD is successfully detected and partitions are displayed.
> 
> The patches are currently based on next-20141009 and I plan to resend
> once v3.18-rc1 drops. A branch based on next-20141009 with this patches
> applied can be found on
> 
> git://git.infradead.org/users/hesselba/linux-berlin.git devel/bg2-sata-v1
> 
> Patch 1 prepares phy-berlin-sata to support different PHY_BASE addresses
> by moving the constant to driver private data.
> 
> Patches 2 and 3 add a new compatible to driver and DT documentation that
> reflects the differences between BG2Q and BG2 SATA PHY.
> 
> Patches 4 and 5 finally add DT nodes to both Berlin2 SoC dtsi and Sony
> NSZ-GS7 board DT file. SATA plug on NSZ-GS7 is unpopulated but can be
> very easily equipped with SATA receptable and some 0402 caps. I decided
> to enable SATA by default although not all users may populate it.

Apart for the little comment, you can add:
Acked-by : Antoine Tenart <antoine.tenart@free-electrons.com>

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
