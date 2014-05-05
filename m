From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 4 May 2014 20:46:27 -0400
Subject: [PATCH 01/15] ARM: dts: kirkwood: fix mislocated
 pcie-controller nodes
In-Reply-To: <1398862602-29595-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1398862602-29595-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140505004627.GC28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 02:56:28PM +0200, Sebastian Hesselbarth wrote:
> Commit 54397d85349f
>  ("ARM: kirkwood: Relocate PCIe device tree nodes")
> 
> moved the pcie-controller nodes for the Kirkwood SoCs to the mbus
> bus node. For some reason, two boards were not properly converted
> and have their pci-controller nodes still in the ocp bus node.
> 
> As the corresponding SoC pcie-controller does not exist anymore,
> it is likely that pcie is broken on those boards since above commit.
> Fix it by moving the pcie related nodes to the correct location.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 18 ++++++++++--------
>  arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi  | 18 ++++++++++--------
>  2 files changed, 20 insertions(+), 16 deletions(-)

Applied to mvebu/dt-fixes with Andrew's Ack and flagged for backporting
to -stable v3.12+

thx,

Jason.
