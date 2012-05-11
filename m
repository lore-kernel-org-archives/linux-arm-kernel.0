From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 11 May 2012 15:02:01 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <1336647675.15424.390.camel@vkoul-udesk3>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
 <1336621458.1540.280.camel@vkoul-udesk3>
 <20120510094205.GM3908@opensource.wolfsonmicro.com>
 <1336647675.15424.390.camel@vkoul-udesk3>
Message-ID: <20120511140201.GC3960@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 04:31:15PM +0530, Vinod Koul wrote:

> This should not be in ASoC library. The driver should be able to detect
> if a tasklet was called for many dma completions and notify the client
> (soc-lib) accordingly.

Certainly if we're going to keep the current API with completions in the
DMA requests I'd really expect that the completions would get called -
if we changed that around then perhaps it'd make more sense for the
audio to keep track of things.  Obviously if we get reliable position
information and audio uses that then this is definitely an ASoC thing.

> One way to do this would be to ensure that the descriptor is marked in
> irq_handler and then all descriptor completed notified in tasklet.

Yes, ideally this would be in the dmaengine core so individual DMA
drivers didn't need to worry about it either.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120511/c3eeb1c5/attachment.sig>
