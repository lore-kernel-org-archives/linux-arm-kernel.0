From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Mar 2014 23:29:42 -0500
Subject: [PATCH v3 3/4] ARM: mvebu: move DT Dove to MVEBU
In-Reply-To: <1393663178-22120-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393538613-28293-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393663178-22120-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140304042942.GK1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 09:39:38AM +0100, Sebastian Hesselbarth wrote:
> With all the DT support preparation done, we are able to move Dove
> to MVEBU easily. Legacy non-DT mach-dove is left untouched to rot
> for a while before removal.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Changelog:
> v1->v2:
> - just rename CONFIG_ARCH_DOVE to CONFIG_MACH_DOVE in dts/Makefile
>   (Suggested by Jason Cooper)
> v2->v3:
> - dropped drivers/phy/Kconfig change, which is now an individual
>   patch sent to Kishon.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/boot/dts/Makefile    |  2 +-
>  arch/arm/mach-dove/Kconfig    | 12 ------------
>  arch/arm/mach-dove/Makefile   |  1 -
>  arch/arm/mach-dove/board-dt.c | 43 -------------------------------------------
>  arch/arm/mach-mvebu/Kconfig   | 12 ++++++++++++
>  arch/arm/mach-mvebu/Makefile  |  1 +
>  arch/arm/mach-mvebu/dove.c    | 39 +++++++++++++++++++++++++++++++++++++++
>  7 files changed, 53 insertions(+), 57 deletions(-)
>  delete mode 100644 arch/arm/mach-dove/board-dt.c
>  create mode 100644 arch/arm/mach-mvebu/dove.c

We'll see how it goes!

Applied to mvebu/soc

thx,

Jason.
