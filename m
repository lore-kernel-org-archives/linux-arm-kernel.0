From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 11 Jun 2012 10:47:55 +0800
Subject: MMC: commit dba3c29 ruins mmc card data on beagle-xm revB
Message-ID: <CACVXFVO-Wm1Qwporby1M=+yPz81AWHpZRBZSbr5tgT32b6sSEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

After bisecting, I found that the commit below can ruin the mmc card data
(writing incorrect file, or fs is corrupt) on my beagle-xm revB, and reverting
the commit below will fix the problem.


commit dba3c29ea4a1d5d544f59b94fd8a41662135e071
Author: Balaji T K <balajitk@ti.com>
Date:   Mon Apr 9 12:08:32 2012 +0530

    mmc: omap_hsmmc: Enable Auto CMD12

    Enable Auto-CMD12 for multi block read/write on HSMMC.
    Tested on OMAP4430, OMAP3430 and OMAP2430 SDP


Thanks,
--
Ming Lei
