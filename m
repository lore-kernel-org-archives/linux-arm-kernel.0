From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 21 May 2013 09:43:27 -0400
Subject: [PATCH 2/9] arm: mvebu: fix length of Ethernet registers area
 in .dtsi
In-Reply-To: <1369132414-18959-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369132414-18959-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130521134327.GS31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 12:33:27PM +0200, Thomas Petazzoni wrote:
> The length of the registers area for the Marvell 370/XP Ethernet
> controller was incorrect in the .dtsi: 0x2400 while it should have
> been 0x4000. Until now, this problem wasn't noticed because there was
> a large static mapping for all I/Os set up by ->map_io(). But since
> we're going to get rid of this static mapping, we need to ensure that
> the register areas are properly sized.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi     |    4 ++--
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi |    2 +-
>  arch/arm/boot/dts/armada-xp.dtsi         |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Applied to mvebu/fixes

thx,

Jason.
