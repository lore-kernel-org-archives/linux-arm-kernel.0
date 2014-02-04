From: horms@verge.net.au (Simon Horman)
Date: Tue, 4 Feb 2014 15:47:27 +0900
Subject: [PATCH 0/8] ARM: shmobile: Conditionally select SMSC_PHY
In-Reply-To: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
References: <1389084488-25984-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20140204064727.GA25513@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 05:48:00PM +0900, Simon Horman wrote:
> Select the SMSC_PHY if ethernet is enabled on shmbile boards
> that have an SMSC phy. This allows the SMSC-specific phy driver
> to be used rather than relying on generic phy code.
> 
> Based on the renesas-devel-v3.13-rc7-20140107 tag
> of my renesas tree.
> 
> Simon Horman (8):
>   ARM: shmobile: ape6evm: Conditionally select SMSC_PHY
>   ARM: shmobile: armadillo800eva: Conditionally select SMSC_PHY
>   ARM: shmobile: bockw: Sort Kconfig node's selections
>   ARM: shmobile: bockw: Conditionally select SMSC_PHY
>   ARM: shmobile: kzm9d: Conditionally select SMSC_PHY
>   ARM: shmobile: kzm9g: Conditionally select SMSC_PHY
>   ARM: shmobile: mackerel: Conditionally select SMSC_PHY
>   ARM: shmobile: marzen: Conditionally select SMSC_PHY
> 
>  arch/arm/mach-shmobile/Kconfig | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

To my surprise I have discovered that the bockw and kzm9g boards
do not boot using NFS root if SMSC_PHY enabled. I have dropped
the SMSC_PHY patches for those boards pending investigation.
