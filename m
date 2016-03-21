From: tony@atomide.com (Tony Lindgren)
Date: Mon, 21 Mar 2016 13:21:07 -0700
Subject: [PATCH 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
In-Reply-To: <56EFB31C.9090103@ti.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191908070.6629@utopia.booyaka.com>
 <56EFB31C.9090103@ti.com>
Message-ID: <20160321202107.GO9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160321 01:39]:
> 
> This is also interesting:
> McBSP2 sidetone is in region 39 and 40 (module and L4 interconnect) which is
> unique in case of OMAP34xx and OMAP35xx, but it is overlapping with GPIO6 on
> OMAP36xx. Not sure what are the implications.

Hmm GPIO6 is in a different L4 segment though? Maybe
you did not account for the segments?

0x49000000 + 0x20000 + 0x2000/0x4000/0x6000 for McBSP
0x49000000 + 0x50000 + 0x8000 for GPIO6

Or maybe I don't understand at which physical address the
overlap is? :)

Let me know if you need me to dump out the IO ranges for
you from the AP table for 34xx and 36xx.

Regards,

Tony
