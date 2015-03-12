From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 12 Mar 2015 14:37:07 +0100
Subject: [PATCH v2 RESEND 0/4] Fix power domains handling on exynos542x
Message-ID: <1426167431-24470-1-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

This is resend of my patchset with added (Reviewed|Tested)-by tags and removed RFC
prefix.

Exynos chipsets since 542x have asynchronous bridges connecting different IPs.
These bridges should be operational during power domain switching, ie associated
clocks cannot be gated.
This patchset adds binding to provide such clocks per power domain and adds code
which enables them during domain on/off operation.

This patchset fixes power domain issues with disp1 domain and HDMI (some of them)
on Odroid XU3:
- disp1 power domain can be turned off,
- no more "imprecise external abort" faults.

The patchset is based on samsung-fixes-dt tag from kgene/linux-samsung.

It was successfully tested on OdroidXU3.

Regards
Andrzej


Andrzej Hajda (4):
  arm/exynos: add asynchronous bridge clock bindings
  arm/exynos/pm_domains: add support for async-bridge clocks
  ARM: dts: exynos5420: add async-bridge clocks to disp1 power domain
  ARM: dts: exynos5420: add async-bridge clocks to gsc power domain

 .../bindings/arm/exynos/power_domain.txt           |  3 +++
 arch/arm/boot/dts/exynos5420.dtsi                  |  8 +++++--
 arch/arm/mach-exynos/pm_domains.c                  | 27 ++++++++++++++++++----
 3 files changed, 32 insertions(+), 6 deletions(-)

-- 
1.9.1
