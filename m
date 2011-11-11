From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 11 Nov 2011 15:16:25 +0800
Subject: [PATCH 1/4] arm/imx: fix mx3_defconfig to add FEC back
In-Reply-To: <20111110085748.GL13122@pengutronix.de>
References: <1320914372-4416-1-git-send-email-shawn.guo@linaro.org>
 <1320914372-4416-2-git-send-email-shawn.guo@linaro.org>
 <20111110085748.GL13122@pengutronix.de>
Message-ID: <20111111071625.GD8732@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 09:57:48AM +0100, Uwe Kleine-K?nig wrote:
> On Thu, Nov 10, 2011 at 04:39:29PM +0800, Shawn Guo wrote:
> > The commit 'd880db0 arm: mx3: update defconfig' removes FEC support
> > which is not good, since FEC is useful for both developers and users.
> 
> $ git show d880db0^:drivers/net/Kconfig | grep -A4 'config FEC$'
> config FEC
> 	bool "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
> 	depends on M523x || M527x || M5272 || M528x || M520x || M532x || \
> 		IMX_HAVE_PLATFORM_FEC || MXS_HAVE_PLATFORM_FEC
> 	default IMX_HAVE_PLATFORM_FEC || MXS_HAVE_PLATFORM_FEC if ARM
> 
> So when d880db0 was created
> 
> 	make savedefconfig
> 
> dropped CONFIG_FEC=y justifiably. The culprit is commit
> 
> 	230dec6 (net/fec: add imx6q enet support)
> 
> which dropped the default line.
> 
Thanks for letting me know that's me :)

Anyway, I put what I see from 'git log -p arch/arm/configs/mx3_defconfig'
there.

-- 
Regards,
Shawn
