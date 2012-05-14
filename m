From: khilman@ti.com (Kevin Hilman)
Date: Mon, 14 May 2012 16:28:15 -0700
Subject: [PATCH 0/2] arm: omap3: am35x: Convert emac to hwmod & disable
 hlt when open
In-Reply-To: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com> (Mark
 A. Greer's message of "Fri, 11 May 2012 14:12:56 -0700")
References: <1336770778-23044-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <874nripckw.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Sekhar,

"Mark A. Greer" <mgreer@animalcreek.com> writes:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> Paul, Kevin,
>
> These patches convert the davinci emac support for the am35x SoC
> to use hwmod and add enable_hlt()/disable_hlt() calls to the
> pm_runtime hooks for that driver.

Great.  I didn't look closely at the hwmod data, but the approach is
right here, IMO.

> I have converted the davinci_emac driver to use pm_runtime but I
> can't formally submit it yet since it requires some changes on the
> mach-davinci side that haven't happened yet.  I will send it as an
> RFC in a reply to this thread.

Sekhar, are you planning to add runtime PM core support to davinci?
I recommend looking at the simple OMAP1 layer that implements a basic
clocks-only runtime PM layer.

Kevin

> The patches are based on:
> 	git://git.pwsan.com/linux-2.6 am35xx_hwmod_data_fixes_a_3.5
>
> Mark
> --
>
> Mark A. Greer (2):
>   arm: omap3: am35x: Add Davinci EMAC/MDIO hwmod support
>   arm: omap3: am35x: Disable hlt when using Davinci EMAC
>
>  arch/arm/mach-omap2/am35xx-emac.c          |  120 ++++++++++++++++++----------
>  arch/arm/mach-omap2/am35xx-emac.h          |   16 +++-
>  arch/arm/mach-omap2/board-am3517evm.c      |    3 +-
>  arch/arm/mach-omap2/board-cm-t3517.c       |    3 +-
>  arch/arm/mach-omap2/clock3xxx_data.c       |    2 +-
>  arch/arm/mach-omap2/include/mach/am35xx.h  |    2 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   85 ++++++++++++++++++++
>  7 files changed, 183 insertions(+), 48 deletions(-)
