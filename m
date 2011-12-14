From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 13 Dec 2011 19:22:45 -0700 (MST)
Subject: [PATCHv11 2/8] ARM: OMAP2+: hwmod: Add API to check IO PAD wakeup
 status
In-Reply-To: <20111213224851.GX32251@atomide.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-3-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1112131505000.12046@utopia.booyaka.com>
 <20111213222804.GV32251@atomide.com>
 <alpine.DEB.2.00.1112131530100.12046@utopia.booyaka.com>
 <20111213224851.GX32251@atomide.com>
Message-ID: <alpine.DEB.2.00.1112131920300.12046@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Dec 2011, Tony Lindgren wrote:

> Hmm yes that's even more true :) Maybe the right approach would be to
> copy the OMAP_DEVICE_PAD_WAKEUP pins also to the dynamic list to
> avoid going through all of them.

Looking at this further, it seems that the best thing to do for now is to 
just add hwmod mux entries with OMAP_DEVICE_PAD_WAKEUP into the dynamic 
list.  Otherwise massive changes will be needed to omap_hwmod_mux() and 
related functions, since those currently only iterate over the dynamic mux 
entries.  Will post the mux patch to do this.


- Paul
