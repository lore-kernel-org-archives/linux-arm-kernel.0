From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Fri, 23 Mar 2012 09:04:46 +0200
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020696D48E3E@AUSP01VMBX24.collaborationhost.net>
References: <4F683B36.8090101@metasoft.pl>
 <20120321193836.GC3740@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48E3E@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20120323070446.GC5812@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2012 at 09:19:10PM -0500, H Hartley Sweeten wrote:

> Did you test this patch or just review it?

I tested and reviewed it.

> On my system it doesn't work. I think it has something to do with the
> changes to m2m_hw_interrupt but I haven't tracked it down yet.
> 
> It looks like what's missing is a:
> 
> 	edmac->edma->hw_submit(edmac);
> 
> But, maybe that's not needed with double buffering?

Did you try without your patch and adding my VIC hack? That's what I did when
I first got this patch and I saw no problems. I tested with audio (M2P),
mmc_spi (M2M) and dmatest (M2M).
