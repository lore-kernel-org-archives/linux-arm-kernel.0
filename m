From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Feb 2012 10:19:58 +0000
Subject: [PATCH] ARM: OMAP: update omap1 and omap2plus defconfigs
In-Reply-To: <1328696173-17226-1-git-send-email-grinberg@compulab.co.il>
References: <20120208053556.GB1426@atomide.com>
 <1328696173-17226-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <20120208101958.GT1275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 12:16:13PM +0200, Igor Grinberg wrote:
> This patch updates omapX_defconfig to 3.3-rc1 and enables
> the CONFIG_DEBUG_SECTION_MISMATCH.

You shouldn't enable this in the kernel supplied defconfigs.

> The update is done by:
> 1) make mrproper && make omapX_defconfig
> 2) Enable the CONFIG_DEBUG_SECTION_MISMATCH
> 3) make savedefconfig
> 4) cp defconfig arch/arm/configs/omapX_defconfig
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> After updating omap1_defconfig,
> there are several section mismatch warnings seen.
> Hopefully, I will have time to fix those tomorrow
> (unless someone will be kind enough to fix them before me).
> The mismatches are:

The correct way is to build with:

make ... CONFIG_DEBUG_SECTION_MISMATCH=y

or set it in your private configuration.
