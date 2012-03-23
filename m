From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 22 Mar 2012 21:19:10 -0500
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <20120321193836.GC3740@mwesterb-mobl.ger.corp.intel.com>
References: <4F683B36.8090101@metasoft.pl>
 <20120321193836.GC3740@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020696D48E3E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 21, 2012 12:39 PM, Mika Westerberg wrote:
> On Tue, Mar 20, 2012 at 09:09:26AM +0100, Rafal Prylowski wrote:
>> Implement double buffering for M2M DMA channels.
>> 
>> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
>
> The subject line prefix should probably be 'dmaengine/ep93xx_dma: ' but
> otherwise this looks good.
>
> Acked-by: Mika Westerberg <mika.westerberg@iki.fi>

Mika,

Did you test this patch or just review it?

On my system it doesn't work. I think it has something to do with the
changes to m2m_hw_interrupt but I haven't tracked it down yet.

It looks like what's missing is a:

	edmac->edma->hw_submit(edmac);

But, maybe that's not needed with double buffering?

Regards,
Hartley
