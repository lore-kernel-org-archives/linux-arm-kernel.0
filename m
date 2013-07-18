From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 18 Jul 2013 08:12:53 -0500
Subject: [PATCH 0/4] Enable ethernet support for SOCFPGA
In-Reply-To: <20130718115951.GA2706@amd.pavel.ucw.cz>
References: <1374102623-4154-1-git-send-email-dinguyen@altera.com>
 <51E7B27F.2000304@communistcode.co.uk>
 <20130718115951.GA2706@amd.pavel.ucw.cz>
Message-ID: <1374153173.9004.4.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jack,

On Thu, 2013-07-18 at 13:59 +0200, ZY - pavel wrote:
> Hi!
> 
> > >These 4 patches are meant to enable ethernet and SD/MMC for the SOCFPGA
> > >platform.
> > >
> > >patch (1/4): Adds select ARM_TWD for the platform
> > >patch (2/4): Add platform specific initialization for the ethernet controller.
> > >patch (3/4): Commit 25c83b5c2 added "snps,phy-addr" for getting the PHY addr.
> > >         Set the ethernet clocks to be emac_0_clk and emac_1_clk so it be gated.
> > >patch (4/4): Update defconfig to support SD/MMC, ethernet, EXT3 and NFS.
> 
> > What tree is this based against, or what patches are a pre-requisite
> > to this series? I applied the patches to linux-arm/master but the
> > compile failed.
> > 
> > arch/arm/mach-socfpga/socfpga.c: In function 'ksz9021rlrn_phy_fixup':
> > arch/arm/mach-socfpga/socfpga.c:85:21: error:
> > 'MICREL_KSZ9021_EXTREG_CTRL' undeclared (first use in this function)
> >    phy_write(phydev, MICREL_KSZ9021_EXTREG_CTRL,
> >                      ^
> 
> It seems it depends on:
> 
> Date: Mon, 15 Jul 2013 18:08:50 -0500
> From: dinguyen at altera.com
> To: dinh.linux at gmail.com, netdev at vger.kernel.org
> Cc: Pavel Machek <pavel@denx.de>, Nicolas Ferre
> <nicolas.ferre@atmel.com>,
>         "David S. Miller" <davem@davemloft.net>,
>         linux-arm-kernel at lists.infradead.org,
>         Shawn Guo <shawn.guo@linaro.org>,
>         Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
>         Andrew Victor <linux@maxim.org.za>,
>         Dinh Nguyen <dinguyen@altera.com>
> Subject: [PATCH] phy: micrel: Add definitions for common Micrel PHY
> registers
> X-Mailer: git-send-email 1.7.9.5
> 
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add defines for common Micrel PHY setups so that other platforms
> can use them. Update imx61 and sama5 hardware to use the micrel_phy.h
> PHY defines.
> 
> Also add support for the KSZ9021RLRN PHY.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Yes, the above patch is necessary. I was hoping that patch can go into
either Shawn's or Nicolas' tree. I have received ACKs from both. There
is also the SD/MMC bindings patch that has not been applied to the
arm-soc tree yet. I have started collecting the patches at github in the
meantime:

git at github.com:dinh-linux/linux-socfpga.git for-next

Dinh
> 
> 									Pavel
