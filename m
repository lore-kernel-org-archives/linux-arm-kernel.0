From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 2 Oct 2018 19:48:17 -0700
Subject: [GIT PULL] i.MX fixes for 4.19, round 2
In-Reply-To: <CAK8P3a0d3C3gDi_Ozh1gBTVXiAOc67_8SOYh7tzWVpP8trO8-A@mail.gmail.com>
References: <20181001023923.GQ26692@dragon>
 <CAK8P3a1e8+HMwsFjE5AJW1E8M309dTkXHLqQb0Dne1gO_n61vg@mail.gmail.com>
 <f31c2fe8e753ba4c21e1c4b4ede270f88dddbf42.camel@pengutronix.de>
 <CAK8P3a0d3C3gDi_Ozh1gBTVXiAOc67_8SOYh7tzWVpP8trO8-A@mail.gmail.com>
Message-ID: <20181003024815.GA4398@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 02:09:10PM +0200, Arnd Bergmann wrote:
> Shawn, should I cherry-pick the other fix, or do you want to
> follow up with a new pull request for the fixes?

Arnd, I just updated the pull request with the patch in question dropped.

Shawn


The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.19-2

for you to fetch changes up to eea96566c189c77e5272585984eb2729881a2f1d:

  ARM: dts: imx53-qsb: disable 1.2GHz OPP (2018-09-12 14:44:33 +0800)

----------------------------------------------------------------
i.MX fixes for 4.19, round 2:
 - i.MX53 QSB board stops working when cpufreq driver is enabled,
   because the default OPP table has the maximum CPU frequency at
   1.2GHz, while the board is only capable of running 1GHz.  Fix up
   the OPP table for the board to get it work with cpufreq driver.

----------------------------------------------------------------
Sascha Hauer (1):
      ARM: dts: imx53-qsb: disable 1.2GHz OPP

 arch/arm/boot/dts/imx53-qsb-common.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)
