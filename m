From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 22 May 2014 10:15:56 -0400
Subject: [PATCH] ARM: mvebu: fix definitions of PCIe interfaces on
 Armada 38x
In-Reply-To: <1400597008-4148-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400597008-4148-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140522141556.GN8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 04:43:28PM +0200, Thomas Petazzoni wrote:
> Due a copy/paste error, the 'reg' values for the third PCIe interface
> on Armada 380, and the third and fourth PCIe interfaces on Armada 385
> are wrong: they are equal to the one of the second PCIe interface.
> 
> This patch fixes this by using the appropriate 'reg' values for those
> PCIe interfaces.
> 
> Without this fix, the third and fourth PCIe interfaces are unusable on
> those platforms.
> 
> Reported-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Fixes: 0d3d96ab0059 ("ARM: mvebu: add Device Tree description of the Armada 380/385 SoCs")
> ---
> This is based on mvebu/dt. It should be pushed to 3.15-rc.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-380.dtsi | 2 +-
>  arch/arm/boot/dts/armada-385.dtsi | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied to mvebu/dt-fixes.

thx,

Jason.
