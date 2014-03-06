From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Mar 2014 15:09:36 -0500
Subject: [PATCH] ARM: mvebu: use the correct phy connection mode on
 Armada 385 DB
In-Reply-To: <1394116915-14424-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1394116915-14424-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140306200936.GH1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 03:41:55PM +0100, Thomas Petazzoni wrote:
> On Armada 385 DB, while the "rgmii" PHY connection mode works fine
> with the generic PHY driver, it fails to work when the Marvell PHY
> driver is enabled in the kernel configuration, due to a finer handling
> of the PHY configuration. This is due to the fact that the phy
> connection mode should instead be "rgmii-id", i.e with the TX/RX delay
> mechanisms enabled.
> 
> This fixes the network operation on Armada 385 DB with
> CONFIG_MARVELL_PHY=y. Without this patch and this option enabled, one
> would only get messages such as:
> 
>   mvneta f1070000.ethernet eth1: bad rx status 0cc10000 (crc error), size=70
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Jason, this commit is based on mvebu/dt-3xx
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-385-db.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/dt (I merged mvebu/dt-3xx into mvebu/dt once it
appeared stable)

thx,

Jason.
