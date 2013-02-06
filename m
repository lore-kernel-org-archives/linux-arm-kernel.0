From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Feb 2013 16:15:32 -0800
Subject: [GIT PULL 2/5] Samsung cleanup-s3c24xx for v3.9
In-Reply-To: <120c01ce0331$389e43a0$a9dacae0$@samsung.com>
References: <120c01ce0331$389e43a0$a9dacae0$@samsung.com>
Message-ID: <20130206001532.GA28722@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 03:41:55PM -0800, Kukjin Kim wrote:
> Hi Arnd and Olof,
> 
> Here is 2nd cleanup for Samsung S3C24XX stuff and based on previous
> pull-request branch, 'next/cleanup-header'.
> Basically, this patch merges mach-s3c2410, mach-s3c2412 and mach-s3c2440
> into mach-s3c24xx.
> 
> Note, this is 2nd pull request and first is 'next/cleanup-header' branch.
> If any problems, please let me know.

Hi,

So, your first pull request didn't contain a "1/5", so it's hard to match them
up.

Also, see how the word wrapping looks below? I wonder if you run your "git
request-pull" in a terminal window that is wider than 80 characters, and then
copy-and-paste it over? That doesn't work well. (I suspect you do since your
git URL is always wrapped too :( )

Finally, would you mind starting to use signed tags with branch descriptions,
or at least give a short overview of the branches in the pull requests?


Thanks.

-Olof

> 
> Thanks.
> 
> - Kukjin
> 
> 
> The following changes since commit 3a71c5c375e29fc9c1493b5ead1cf36572139c3e:
> 
>   ARM: S3C64XX: Fix missing header error with CONFIG_CPU_IDLE enabled
> (2013-01-10 10:45:41 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/cleanup-s3c24xx
> 
> for you to fetch changes up to acf2d41d8595829eb0ac7bf6891f4875a78d4d6e:
> 
>   ARM: S3C24XX: Move mach-s3c2440/ pll into mach-s3c24xx/ (2013-01-21
> 17:05:23 -0800)
> 
> ----------------------------------------------------------------
> Kukjin Kim (6):
>       ARM: S3C24XX: Move mach-s3c2410/ cpufreq into mach-s3c24xx/
>       ARM: S3C24XX: Move mach-s3c2410/ pll into mach-s3c24xx/
>       ARM: S3C2412: Remove useless codes mach-s3c2412/gpio.c
>       ARM: S3C24XX: Move mach-s3c2412/ cpufreq driver into mach-s3c24xx/
>       ARM: S3C24XX: Move mach-s3c2440/ cpufreq driver into mach-s3c24xx/
>       ARM: S3C24XX: Move mach-s3c2440/ pll into mach-s3c24xx/
> 
>  arch/arm/Kconfig
> |    4 ----
>  arch/arm/Makefile
> |    2 +-
>  arch/arm/mach-s3c2410/Kconfig
> |   20 ----------------
>  arch/arm/mach-s3c2410/Makefile
> |   14 -----------
>  arch/arm/mach-s3c2412/Kconfig
> |   13 ----------
>  arch/arm/mach-s3c2412/Makefile
> |   12 ----------
>  arch/arm/mach-s3c2412/gpio.c
> |   62 ------------------------------------------------
>  arch/arm/mach-s3c2440/Kconfig
> |   37 -----------------------------
>  arch/arm/mach-s3c2440/Makefile
> |   15 ------------
>  arch/arm/mach-s3c24xx/Kconfig
> |   56 +++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-s3c24xx/Makefile
> |    6 +++++
>  arch/arm/{mach-s3c2410/cpu-freq.c => mach-s3c24xx/cpufreq-s3c2410.c}
> |    7 ++----
>  arch/arm/{mach-s3c2412/cpu-freq.c => mach-s3c24xx/cpufreq-s3c2412.c}
> |    6 ++---
>  arch/arm/{mach-s3c2440/s3c2440-cpufreq.c => mach-s3c24xx/cpufreq-s3c2440.c}
> |    4 +---
>  arch/arm/mach-s3c24xx/include/mach/hardware.h
> |    6 -----
>  arch/arm/{mach-s3c2410/pll.c => mach-s3c24xx/pll-s3c2410.c}
> |    5 +---
>  arch/arm/{mach-s3c2440/s3c2440-pll-12000000.c =>
> mach-s3c24xx/pll-s3c2440-12000000.c} |    5 +---
>  arch/arm/{mach-s3c2440/s3c2440-pll-16934400.c =>
> mach-s3c24xx/pll-s3c2440-16934400.c} |    5 +---
>  18 files changed, 71 insertions(+), 208 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c2410/Kconfig
>  delete mode 100644 arch/arm/mach-s3c2410/Makefile
>  delete mode 100644 arch/arm/mach-s3c2412/Kconfig
>  delete mode 100644 arch/arm/mach-s3c2412/Makefile
>  delete mode 100644 arch/arm/mach-s3c2412/gpio.c
>  delete mode 100644 arch/arm/mach-s3c2440/Kconfig
>  delete mode 100644 arch/arm/mach-s3c2440/Makefile
>  rename arch/arm/{mach-s3c2410/cpu-freq.c => mach-s3c24xx/cpufreq-s3c2410.c}
> (98%)
>  rename arch/arm/{mach-s3c2412/cpu-freq.c => mach-s3c24xx/cpufreq-s3c2412.c}
> (99%)
>  rename arch/arm/{mach-s3c2440/s3c2440-cpufreq.c =>
> mach-s3c24xx/cpufreq-s3c2440.c} (99%)
>  rename arch/arm/{mach-s3c2410/pll.c => mach-s3c24xx/pll-s3c2410.c} (99%)
>  rename arch/arm/{mach-s3c2440/s3c2440-pll-12000000.c =>
> mach-s3c24xx/pll-s3c2440-12000000.c} (98%)
>  rename arch/arm/{mach-s3c2440/s3c2440-pll-16934400.c =>
> mach-s3c24xx/pll-s3c2440-16934400.c} (99%)
> 
