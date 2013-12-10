From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Dec 2013 16:26:16 -0800
Subject: [GIT PULL] ARM: OMAP2+: hwmod code/data: fixes for v3.13-rc
In-Reply-To: <alpine.DEB.2.02.1312091906150.32309@utopia.booyaka.com>
References: <alpine.DEB.2.02.1312091906150.32309@utopia.booyaka.com>
Message-ID: <20131210002616.GD13171@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

Care to pull this one from Paul into the fixes too?

Regards,

Tony

* Paul Walmsley <paul@pwsan.com> [131209 11:08]:
> Hi Tony,
> 
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13-rc/hwmod-fixes-a
> 
> for you to fetch changes up to 0e7dc862cf687234ed1b01a6b2461b782ea0bca0:
> 
>   ARM: OMAP2+: hwmod: Fix usage of invalid iclk / oclk when clock node is not present (2013-12-09 11:51:30 -0700)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: hwmod code/data: fixes for v3.13-rc
> 
> Fix a few hwmod code problems involving recovery with bad data and bad
> IP block OCP reset handling.  Also, fix the hwmod data to enable IP
> block OCP reset for the OMAP USBHOST devices on OMAP3+.
> 
> Basic build, boot, and PM tests are available here:
> 
> http://www.pwsan.com/omap/testlogs/prcm_fixes_a_v3.13-rc/20131209030611/
> 
> ----------------------------------------------------------------
> Nishanth Menon (1):
>       ARM: OMAP2+: hwmod: Fix usage of invalid iclk / oclk when clock node is not present
> 
> Roger Quadros (3):
>       ARM: OMAP4+: hwmod data: Don't prevent RESET of USB Host module
>       ARM: OMAP2+: hwmod: Fix SOFTRESET logic
>       ARM: OMAP3: hwmod data: Don't prevent RESET of USB Host module
> 
>  arch/arm/mach-omap2/omap_hwmod.c           | 45 +++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 13 ++-------
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 12 ++------
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 13 ++-------
>  4 files changed, 52 insertions(+), 31 deletions(-)
> 
