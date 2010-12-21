From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 21 Dec 2010 10:34:27 +0000
Subject: [PATCH 2/2] ARM: use cached memory in dma_alloc_coherent() if
	possible
In-Reply-To: <20101221103057.GK28157@n2100.arm.linux.org.uk>
References: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
	<1292926802-12326-2-git-send-email-jamie@jamieiles.com>
	<20101221103057.GK28157@n2100.arm.linux.org.uk>
Message-ID: <20101221103427.GC2822@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 21, 2010 at 10:30:57AM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 21, 2010 at 10:20:02AM +0000, Jamie Iles wrote:
> > For fully coherent architectures or systems using the ARM ACP to provide
> > coherency to individual device, use cached memory as the coherent
> > backing rather than noncached or simply bufferable memory.
> 
> As has already been covered by Catalin, as far as we know, no one uses
> the ACP yet.  Do you have a system which does?

No, not yet. I was looking at this to see what the impact would be if we did 
though with regards to the CPU side of things for future devices and thought 
someone else may find it useful.

Jamie
