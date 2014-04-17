From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Apr 2014 01:13:17 -0400
Subject: [PATCH 3/3] ARM: mvebu: use qsgmii phy-mode for Armada XP GP
 interfaces
In-Reply-To: <1397569821-5530-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397569821-5530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397569821-5530-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140417051317.GQ28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 03:50:21PM +0200, Thomas Petazzoni wrote:
> The Armada XP GP isn't using rgmii-id connections between the MAC and
> PHY, but instead a single QSGMII connection, which is a quad-SGMII
> connection: a double pair of differential lines that are multiplexed
> to convey the traffic of four network interfaces between a MAC and a
> PHY.
> 
> Until now, the Armada XP GP was relying on the bootloader setting the
> correct values in various configuration registers. With this change,
> the mvneta driver can be used as a module on this platform.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-gp.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to mvebu/dt-fixes with Willy and Arnaud's Tested-by's

thx,

Jason.
