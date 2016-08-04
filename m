From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 4 Aug 2016 13:28:35 +0300
Subject: [PATCHv3 00/11] crypto: omap HW crypto fixes
Message-ID: <1470306526-27219-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This revision took quite a bit time to craft due to the rework needed
for sham buffer handling and export/import. I ended up implementing
a flush functionality for draining out the sham buffer when doing
export/import; just shrinking the buffer to sufficiently small size
impacted the performance with small data chunks too much so I dropped
this approach.

The series also fixes a couple of existing issues with omap2/omap3
hardware acceleration, I ran a full boot test / crypto manager
test suite on all boards accessible to me now.

Based on top of latest mainline, which is somewhere before 4.8-rc1
as of writing this, I am unable to rebase the series during the next
three weeks so wanted to get this out now. Targeted for 4.9 merge
window, some fixes could be picked up earlier though if needed.

-Tero
