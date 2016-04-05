From: david.s.gordon@intel.com (Dave Gordon)
Date: Tue, 5 Apr 2016 08:11:48 +0100
Subject: [PATCH v2 4/7] scatterlist: add sg_alloc_table_from_buf() helper
In-Reply-To: <20160330201831.38e1d6bd@bbrezillon>
References: <1459352394-22810-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459352394-22810-5-git-send-email-boris.brezillon@free-electrons.com>
 <20160330165143.GI2350@sirena.org.uk> <20160330201831.38e1d6bd@bbrezillon>
Message-ID: <57036534.7010800@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/03/16 19:18, Boris Brezillon wrote:
> On Wed, 30 Mar 2016 09:51:43 -0700
> Mark Brown <broonie@kernel.org> wrote:
>
>> On Wed, Mar 30, 2016 at 05:39:51PM +0200, Boris Brezillon wrote:
>>> sg_alloc_table_from_buf() provides an easy solution to create an sg_table
>>> from a virtual address pointer. This function takes care of dealing with
>>> vmallocated buffers, buffer alignment, or DMA engine limitations (maximum
>>> DMA transfer size).
>>
>> This seems nice.  Should we also have a further helper on top of this
>> which will get constraints from a dmaengine, it seems like it'd be a
>> common need?
>
> Yep, we could create a wrapper extracting dma_slave caps info,
> converting it to sg_constraints and calling sg_alloc_table_from_buf().
> But let's try to get this function accepted first, and I'll send another
> patch providing this wrapper.
>
> BTW, do you see other things that should be added in sg_constraints?
>

You could compare with the things Solaris uses to describe the 
restrictions on a DMA binding ...

http://docs.oracle.com/cd/E23824_01/html/821-1478/ddi-dma-attr-9s.html#REFMAN9Sddi-dma-attr-9s

.Dave.
