From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 May 2016 13:23:12 +0800
Subject: [PATCH 0/2] ARM: dts: sun6i: Drop constraints on dc1sw regulator
Message-ID: <1462944194-6920-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are 2 last minute fixes for 4.6. The 2 patches drop constaints on
the dc1sw regulator for 2 A31s tablets. I checked with Maxime and he said
to send them directly to you.

The issue was first brought up and fixed for A23/A33 Q8 tablets in commit
dcf5341f0150 ("ARM: dts: sun8i-q8-common: Do not set constraints on dc1sw
regulator"). It was brought up again yesterday on IRC, and I realized that
2 sun6i A31s tablet DTS files also had this setting. The setting causes
PMIC regulator registration to fail, and since among other things, mmc
depends on the regulators, the system will likely hang.

There seems to be a fix for this queued up for 4.7: commit 45389c47526d
("regulator: core: Add early supply resolution for regulators") in the
regulator "supply" topic branch. So we should be able to revert these
fixes in 4.7.


Regards
ChenYu


Chen-Yu Tsai (2):
  ARM: dts: sun6i: primo81: Drop constraints on dc1sw regulator
  ARM: dts: sun6i: yones-toptech-bs1078-v2: Drop constraints on dc1sw
    regulator

 arch/arm/boot/dts/sun6i-a31s-primo81.dts                 | 2 --
 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts | 2 --
 2 files changed, 4 deletions(-)

-- 
2.8.1
