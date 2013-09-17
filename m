From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 17 Sep 2013 14:35:03 -0300
Subject: mvebu: Armada XP doesn't boot in v3.12-rc1
Message-ID: <20130917173502.GA4231@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Armada XP boards are not booting in v3.12-rc1.

These two patches, which are already in linux-mvebu/mvebu/dt,
are needed to fix the problem:

commit 585b136b73696ac37c9614b4b3d8fa0407adcdf1
Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date:   Tue Aug 20 12:45:51 2013 -0300

    ARM: mvebu: Add clock properties to Armada XP timer node

commit d36fd447d5e2d0993a8ec34afc26fc449ac1e2f3
Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date:   Tue Aug 20 12:45:50 2013 -0300

    ARM: mvebu: Add the reference 25 MHz fixed-clock to Armada XP

---

FWIW, CONFIG_HAVE_ARM_ARCH_TIMER=y is also needed or the board freezes,
but that's another problem which I'm currently investigating.

Can you push the above two to be included in v3.12-rc1 or do you need
anything else from me?

Thanks and sorry for the crap,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
