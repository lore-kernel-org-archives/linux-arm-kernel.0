From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Sep 2018 12:24:53 +0800
Subject: [GIT PULL] Allwinner fixes for v4.19 - Round 2
Message-ID: <20180920042453.GA18194@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a second fixes pull request for arm-soc, based on the first pull
request I sent earlier.

Also, I seem to remember seeing on ksummit-discuss that single patch PRs
are a bit annoying. Would the maintainers prefer we just resend single
patches instead? I'm not sure how that would work out if we later had
to base -next material on it, but I guess we could base it off a -fixes
branch in arm-soc.

Thanks
ChenYu

The following changes since commit d177c8b61d6b4ef360b1c2682e4d8e3bae01738b:

  arm64: allwinner: dts: h6: fix Pine H64 MMC bus width (2018-08-27 09:21:00 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.19-2

for you to fetch changes up to 13b91ed77a65cf3bf23353880245d0cbd9138294:

  ARM: dts: sun8i: drop A64 HDMI PHY fallback compatible from R40 DT (2018-09-20 11:48:01 +0800)

----------------------------------------------------------------
Allwinner fixes - round 2

One additional fix regarding HDMI on the R40 SoC.

Based on preliminary tests and code dumps for the R40, it was thought
that the whole HDMI block was the same on the R40 and A64.

Recent tests regarding the A64 showed that this was not the case. The
HDMI PHY on the A64 only has one clock parent. How this occurs at the
hardware level is unclear, as Allwinner has not given any feedback on
this matter. Nevertheless it is clear that the hardware acts differently
between the A64 and R40 in such a way that the R40's HDMI PHY is not
backward compatible with the A64's. As such we need to drop the fallback
compatible string in the R40's device tree. This was added in v4.19-rc1.

----------------------------------------------------------------
Icenowy Zheng (1):
      ARM: dts: sun8i: drop A64 HDMI PHY fallback compatible from R40 DT

 arch/arm/boot/dts/sun8i-r40.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
