From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jul 2010 13:48:50 +0100
Subject: Memory type used for ioremap
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
Message-ID: <20100709124850.GH22845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 09, 2010 at 07:46:31AM +0530, Pedanekar, Hemant wrote:
> I have few doubts regarding the memory type configured when we call
> ioremap for mapping a region (e.g., on-chip peripheral MMRs):

What's a MMR?

> Please note that this is regarding Cortx A8.
> 
> After examining 2nd level page descriptor, I see that the memory
> type configured for ioremapped region (as per TEX[2:0]=1 and CB=0)

That is correct.  TEX=001 C=0 B=0.

> is "Outer and Inner Non-cacheable - Normal".

I think that's where you're wrong.  TEX=001 C=0 B=0 is device memory.
On ARMv6 with fixed TEX values, this is described in the architecture
reference manual, and is 'shared device'.  On ARMv7 (which Cortex A8 is)
with TEX remapping, we arrange for this bit combination to be 'device'
and the shared-ness of the mapping depends on the S bit.
