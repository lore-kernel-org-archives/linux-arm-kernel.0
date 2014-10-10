From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 10 Oct 2014 17:06:27 +0300
Subject: [REPOST PATCH 0/2] ARM: OMAP3+: VCVP mapping fixes to get DVFS working
Message-ID: <1412949989-20186-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Seems like MPU DVFS does not scale the voltages currently with DT boot,
due to missing mapping between regulator -> VCVP. Fixed this by adding
support for platform data in the TWL regulator DT case + adding platform
data quirk for the same. This same already works in the legacy boot, the
platform data is passed fine.

Tested on omap3-beagle by measuring the MPU voltage rail.

OMAP4+ platforms do not currently register DVFS regulator, so this set by
itself does not fix OMAP4 (needs the TPS MPU regulator added to DT etc.
for OMAP4460.)

-Tero
