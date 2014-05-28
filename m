From: nm@ti.com (Nishanth Menon)
Date: Wed, 28 May 2014 16:46:48 -0500
Subject: [PATCH V2 0/2] power: twl4030_charger: cleanup to handle various
 battery handling error conditions
Message-ID: <1401313610-14252-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This issue was originally reported by Russell on OMAP3-LDP platform,
and original attempt to solve this by Felipe[1] did not quiet work,
follow on attempt[2] seems to be effective, but in this resend, I have
added an shutdown attempt in case things dont quiet look right.

Based on: v3.15-rc7

Tests:
ldp boot with battery: http://slexy.org/raw/s20StiV4xr
ldp boot with a/c charger, no battery: http://slexy.org/raw/s2UfjIkZKG
ldp boot with a/c charger+battery, remove battery: http://slexy.org/raw/s2yFTVlrWJ
	^^ <- this is not exactly a safe test to perform :)..

Nishanth Menon (2):
  power: twl4030_charger: detect battery presence prior to enabling    
    charger
  power: twl4030_charger: attempt to power off in case of critical
    events

 drivers/power/twl4030_charger.c |   70 +++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 6 deletions(-)

[1] https://patchwork.kernel.org/patch/4002371/
[2] https://patchwork.kernel.org/patch/4124751/
-- 
1.7.9.5
