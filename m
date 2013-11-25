From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 25 Nov 2013 13:25:22 -0500
Subject: [PATCH 4/4] ARM: mvebu: re-enable PCIe on Armada 370 DB
In-Reply-To: <1385396807-19027-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1385396807-19027-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1385396807-19027-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20131125182522.GD2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 05:26:47PM +0100, Thomas Petazzoni wrote:
> Commit 14fd8ed0a7fd19913 ("ARM: mvebu: Relocate Armada 370/XP PCIe
> device tree nodes") relocated the PCIe controller DT nodes one level
> up in the Device Tree, to reflect a more correct representation of the
> hardware introduced by the mvebu-mbus Device Tree binding.
> 
> However, while most of the boards were properly adjusted accordingly,
> the Armada 370 DB board was left unchanged, and therefore, PCIe is
> seen as not enabled on this board. This patch fixes that by moving the
> PCIe controller node one level-up in armada-370-db.dts.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: stable at vger.kernel.org
> ---
> This problem exists since kernel v3.12, and therefore this patch
> should probably be pushed to v3.12 stable.
> ---
>  arch/arm/boot/dts/armada-370-db.dts | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Applied to mvebu/dt-fixes

thx,

Jason.
