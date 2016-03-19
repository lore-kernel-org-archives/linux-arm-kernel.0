From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 19 Mar 2016 19:37:33 +0000 (UTC)
Subject: [PATCH 3/3] ASoC: omap-mcbsp: Enable/disable sidetone block auto
 clock gating for omap3
In-Reply-To: <1458296929-718-4-git-send-email-peter.ujfalusi@ti.com>
References: <1458296929-718-1-git-send-email-peter.ujfalusi@ti.com>
 <1458296929-718-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.02.1603191932240.6629@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Mar 2016, Peter Ujfalusi wrote:

> OMAP3's McBSP2 and McBSP3 module have integrated sidetone block with
> dedicated SYSCONFIG register. The sidetone is operating from the maain
> McBSP module's ICLK. For normal operation the sidetone clock auto idle
> support needs to be disabled when it is activated.
> Note: This is not enough to avoid choppy sidetone because this AUTOIDLE
> bit is controlling only the clock auto idle from the McBSP to the sidetone
> block. If the McBSP_ICLK is idling, the sidetone clock is going to do the
> same.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Mark, please drop this patch for the time being, until the SoC integration 
issues can be sorted out first.  It's best to wait a little while before 
applying patches like these so folks have a chance to comment on their 
correctness first.

We used to handle this problem in the OMAP hwmod SoC integration layer 
with a flag that forced the interface clock to stay active as long as the 
underlying IP blocks were active.  However I can't find that flag right 
now in the current data, so maybe it got accidentally or inadvertently 
removed at some point in time in the past.  The right way to fix this 
would be to add that flag back in, rather than messing with the SoC 
integration registers from the McBSP drivers.


thanks


- Paul
