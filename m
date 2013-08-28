From: olof@lixom.net (Olof Johansson)
Date: Wed, 28 Aug 2013 11:50:45 -0700
Subject: [GIT PULL] non-critical omap fixes for v3.12 merge window
In-Reply-To: <20130823054609.GW7656@atomide.com>
References: <20130823054609.GW7656@atomide.com>
Message-ID: <20130828185045.GI8607@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 10:46:10PM -0700, Tony Lindgren wrote:

> Matus Ujhelyi (1):
>       ARM: OMAP2+: am33xx-restart: trigger warm reset on omap2+ boards

Sigh. am33xx has been a bit of a pain this release cycle. Can you please
start double-checking builds when you apply am33xx stuff? :(

This breaks with:

        multi_v7_defconfig:
arch/arm/mach-omap2/am33xx-restart.c:27:26: error: 'AM33XX_RST_GLOBAL_WARM_SW_MASK' undeclared (first use in this function)

        omap2plus_defconfig:
arch/arm/mach-omap2/am33xx-restart.c:27:26: error: 'AM33XX_RST_GLOBAL_WARM_SW_MASK' undeclared (first use in this function)


I've unmerged the branch until that's resolved.

-Olof
