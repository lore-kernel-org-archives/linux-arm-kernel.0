From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jul 2010 15:14:16 +0100
Subject: Memory type used for ioremap
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181CAD@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
	<1278677464.11895.41.camel@e102109-lin.cambridge.arm.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E181CAD@dbde02.ent.ti.com>
Message-ID: <20100709141416.GI22845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 09, 2010 at 07:32:46PM +0530, Pedanekar, Hemant wrote:
> Catalin,
> 
> I was trying to map peripheral region (memory mapped) nd faced problem with w
> 
> This prompted me to check if there were any differences in mapping the region
> 
> As per ARM ARM, TEX=0 is "Strongly-ordered" while TEX=1 is "Normal" memory ty

It'd help if I could see more of your mail than just the above when
replying to it.  Please wrap your messages rather than typing entire
paragraphs on one single line.

<save this message, go back and read your original, re-edit reply>

I think your problem might be to do with how the interconnects work.
Each different memory type can have a different memory map.  If your
peripheral is _only_ visible via the strongly ordered memory type,
then it won't be visible via (shared or non-shared) device or memory
like mappings.

We have had devices in the past where certain peripherals are only
visible via non-shared device mappings.  Could this be one of them?

Without knowing more about the device you're using, in particular
how the bus matrix is setup, there's no way to comment definitively.
What does the documentation for your device say about the type of
mappings required for this peripheral?
