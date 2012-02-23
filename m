From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Feb 2012 14:27:00 +0000
Subject: [GIT PULL] i.MX assorted
In-Reply-To: <20120217082426.GO3852@pengutronix.de>
References: <20120217082426.GO3852@pengutronix.de>
Message-ID: <201202231427.00938.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 February 2012, Sascha Hauer wrote:
> Hi Olof,
> 
> Please pull the following assorted updates for i.MX.
> 

Hi Sascha,

I've pulled it into a generic next/devel branch now, but I'd prefer
avoiding such catch-all branches in the future.

I'd be happier if you could send separate pull requests for independent
parts of this:

fixes:
      ARM: mach-pcm038: Fix field name of regulator_consumer_supply struct
      ARM: imx_v4_v5_defconfig: Fix the selection of 32 bit flash support for iMX21ADS board

drivers:
      ARM: imx_v6_v7_defconfig: Add support for framebuffer and camera on mx31
      ARM: mx27_3ds: Add camera support
      ARM: imx_v4_v5_defconfig: Update defconfig

cleanup:
      ARM: plat-mxc: audmux-v1: Remove unneeded ifdef's
      ARM: mx3: Let mx31 and mx35 share the same CCM header file

I did not want to do that rebase myself because I don't know if the branch
you sent me is used elsewhere, but if you send me replacements, I'd prefer
removing this one branch from arm-soc and putting the three others in.

	Arnd
