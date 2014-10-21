From: nm@ti.com (Nishanth Menon)
Date: Tue, 21 Oct 2014 15:22:27 -0500
Subject: [PATCH 0/2] ARM: OMAP4+: PM: centralize static dependency mapping
 table
Message-ID: <1413922949-22300-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a small step towards getting rid of static dependency logic
from mach-omap2. As part of this, we split the list of static dep
map from the function implementing it. This should eventually aid in
helping remove the tables from the kernel to the device tree at a
later point in time of cleanup.

Series based on v3.18-rc1 and could be a 3.19-rc1 material.

Nishanth Menon (2):
  ARM: OMAP4: PM: Only do static dependency configuration in
    omap4_init_static_deps
  ARM: OMAP4+: PM: Centralize static dependency mapping table

 arch/arm/mach-omap2/pm44xx.c |  146 +++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 80 deletions(-)

-- 
1.7.9.5
