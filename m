From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 17:30:04 +0100
Subject: [GIT PULL] ARM: imx: SoC updates for 3.19
In-Reply-To: <20141119070306.GF27759@dragon>
References: <20141119070306.GF27759@dragon>
Message-ID: <201411201730.04562.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014, Shawn Guo wrote:
> The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9:
> 
>   Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-3.19
> 
> for you to fetch changes up to dc7aaa041842eb40be7ad7bde0a7e37ac1efd79c:
> 
>   ARM: configs: imx_v6_v7_defconfig: add power off driver (2014-11-19 11:51:55 +0800)
> 
> ----------------------------------------------------------------
> The i.MX SoC update for 3.19:
>  - Update i.MX6 suspend code to check DDR instead of CPU type, as the
>    difference we need to handle is between LPDDR2 and DDR3, not SoCs.
>  - Set anatop properly for LPDDR2 in DSM mode
>  - Add support for new SoC LS1021A which integrates dual Cortex-A7
>  - Add ENET initialization for i.MX6SX platform
>  - Add cpufreq support for i.MX53 platform
>  - Add a SNVS based poweroff driver for i.MX6 platforms
>  - Use ARM  Global Timer as clocksource on VF610
>  - Some defconfig updates

Hi Shawn,

The changes all look good, but could you please send them again based on
v3.18-rc1? I'm trying to avoid back-merges from upstream into the next
branches.

Also, note that we've started splitting out defconfig changes into
a separate topic branch. Since you are rebasing anyway, please send
the defconfig change as a separate patch or pull request and also
update multi_v7_defconfig in the same way.

	Arnd
