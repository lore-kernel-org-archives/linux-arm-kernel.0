From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jun 2011 21:41:27 +0100
Subject: [PATCH v2 1/3] dmaengine: add new dma API for max_segment_number
In-Reply-To: <BANLkTikFKr+3Qph+CR40SUV-DCir1v=KBg@mail.gmail.com>
References: <BANLkTin7mqqTsosPHbztaPfL7s_TUGT1qg@mail.gmail.com>
	<20110608142121T.fujita.tomonori@lab.ntt.co.jp>
	<BANLkTi=FcNncT_6HpvB_6OnQ94f0_sz7Gw@mail.gmail.com>
	<20110608160844E.fujita.tomonori@lab.ntt.co.jp>
	<BANLkTikFKr+3Qph+CR40SUV-DCir1v=KBg@mail.gmail.com>
Message-ID: <20110608204127.GC13151@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 01:05:57PM -0700, Dan Williams wrote:
> Even if that were the case it would be same situation that the scsi device
> driver reports maximum parameters, but the subsystem opts for
> something tighter.  Whether the maximal parameters come from the scsi
> device or the dma channel is moot.

Except for the small issue that many DMA-engine using devices do not
have _any_ DMA capabilities of their own, which means they don't have
anything to put in their own struct device's DMA parameters.  We can't
go around making up random insane parameters in the hope that they'll
exceed whatever DMA-engine is being used with the device - that's a
hack not a solution.
