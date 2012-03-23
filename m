From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Fri, 23 Mar 2012 09:00:39 +0200
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020696D48E1A@AUSP01VMBX24.collaborationhost.net>
References: <4F683B36.8090101@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F0020696D488E3@AUSP01VMBX24.collaborationhost.net>
 <20120321193231.GA3740@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48AB1@AUSP01VMBX24.collaborationhost.net>
 <20120322073750.GA637@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48CAF@AUSP01VMBX24.collaborationhost.net>
 <20120322200339.GA5812@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48E1A@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20120323070039.GB5812@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2012 at 06:56:30PM -0500, H Hartley Sweeten wrote:

> I wonder if the spurious interrupts were the real problem behind what
> was causing the Oops that prompted your patch:
> 
> dma/ep93xx_dma: prevent ep93xx_dma_tasklet() to reference an empty list

No, it was a different problem spotted by Rafal. It was related to calling
dma_terminate_all() in a interrupt context or something like that.
