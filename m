From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Jul 2011 17:25:12 +0200
Subject: [GIT PULL] DaVinci features for v3.1
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D9B56E8@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024D9B56E8@dbde02.ent.ti.com>
Message-ID: <201107081725.13174.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 July 2011, Nori, Sekhar wrote:
> Please pull the following DaVinci features for v3.1.
> 
> This pull request depends on the patch "davinci: dm6467/T EVM: fix setting
> up of reference clock rate" in clean-up pull request for successful build.
>
> Pulling this after the earlier clean-up pull request generates this merge
> conflict:
> 
> <<<<<<< HEAD:arch/arm/mach-davinci/include/mach/psc.h
> #define MDSTAT_STATE_MASK       0x1f
> =======
> #define MDSTAT_STATE_MASK 0x1f
> #define MDCTL_FORCE             BIT(31)
> >>>>>>> 8bb2c4813c534d26eba3beb7888fbd3cbc931f62:arch/arm/mach-davinci/include/mach/psc.h
> 
> The resolution is:
> 
> #define MDSTAT_STATE_MASK       0x1f
> #define MDCTL_FORCE             BIT(31)

Ok.

>  arch/arm/mach-davinci/board-da850-evm.c    |    7 ++
>  arch/arm/mach-davinci/clock.c              |    8 +-
>  arch/arm/mach-davinci/clock.h              |    1 +
>  arch/arm/mach-davinci/da850.c              |   10 ++
>  arch/arm/mach-davinci/devices-da8xx.c      |  126 ++++++++++++++++++++++++++++
>  arch/arm/mach-davinci/include/mach/da8xx.h |    2 +
>  arch/arm/mach-davinci/include/mach/psc.h   |    3 +-
>  arch/arm/mach-davinci/psc.c                |   14 +++-
>  8 files changed, 164 insertions(+), 7 deletions(-)

I think we'll have to revisit the AHCI change at some point, I think
spreading the initialization code over all subarchitectures is not
going to scale in the long run. It's ok for now, but I'll keep
an eye on it so we don't add more of these.

>  git://gitorious.org/linux-davinci/linux-davinci.git cleanup

I've pulled it into the davinci/devel branch, to follow the same naming as
the as imx feature branch I've pulled earlier.

Thanks,

	Arnd
