From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 27 Jun 2011 12:23:46 +0800
Subject: [PATCH v4 0/4] Extend sdhci-esdhc-imx card_detect and
	write_protect support for mx5
In-Reply-To: <m27h88djf6.fsf@bob.laptop.org>
References: <1308667311-1855-1-git-send-email-shawn.guo@linaro.org>
	<20110627013826.GB21415@S2100-06.ap.freescale.net>
	<m27h88djf6.fsf@bob.laptop.org>
Message-ID: <20110627042345.GA21757@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2011 at 11:47:57PM -0400, Chris Ball wrote:
> Hi Shawn,
> 
> On Sun, Jun 26 2011, Shawn Guo wrote: 
> >>  arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    3 +-
> >>  arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |    3 +-
> >>  arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +
> >>  arch/arm/mach-imx/mach-pcm043.c                    |    2 +
> >>  arch/arm/mach-mx5/board-mx51_babbage.c             |   14 +-
> >>  arch/arm/mach-mx5/board-mx53_loco.c                |    4 +
> >>  .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   12 ++
> >>  arch/arm/plat-mxc/include/mach/esdhc.h             |   25 +++-
> >>  drivers/mmc/host/sdhci-esdhc-imx.c                 |  140 ++++++++++++--------
> >>  drivers/mmc/host/sdhci.c                           |   29 ++++-
> >>  10 files changed, 165 insertions(+), 69 deletions(-)
> >
> > Is the series ready for being merged?  Or is there anything needs
> > to be done before you do so?
> 
> I'll need to rebase mmc-next onto linux-next before I can merge it,
> because the mach-imx/ board files you're modifying do not exist in
> Linus' tree.  (I don't mind doing that, but it might be easier if
> you had the ARM patches go in via a different tree instead.)
> 
I can ask Sascha to pick up patch #4 with your ack.  But the problem
is patch #4 has to work with #1 applied first, otherwise the CD
interrupt storm will freeze the system.

-- 
Regards,
Shawn
