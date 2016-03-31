From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 31 Mar 2016 16:45:57 +0200
Subject: [PATCH 2/4] scatterlist: add sg_alloc_table_from_buf() helper
In-Reply-To: <20160331141412.GK19428@n2100.arm.linux.org.uk>
References: <1459427384-21374-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459427384-21374-3-git-send-email-boris.brezillon@free-electrons.com>
 <20160331141412.GK19428@n2100.arm.linux.org.uk>
Message-ID: <20160331164557.544ed780@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, 31 Mar 2016 15:14:13 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Mar 31, 2016 at 02:29:42PM +0200, Boris Brezillon wrote:
> > sg_alloc_table_from_buf() provides an easy solution to create an sg_table
> > from a virtual address pointer. This function takes care of dealing with
> > vmallocated buffers, buffer alignment, or DMA engine limitations (maximum
> > DMA transfer size).
> 
> Please note that the DMA API does not take account of coherency of memory
> regions other than non-high/lowmem - there are specific extensions to
> deal with this.

Ok, you said 'non-high/lowmem', this means vmalloced and kmapped buffers
already fall in this case, right?

Could you tell me more about those specific extensions?

> 
> What this means is that having an API that takes any virtual address
> pointer, converts it to a scatterlist which is then DMA mapped, is
> unsafe.

Which means some implementations already get this wrong (see
spi_map_buf(), and I'm pretty sure it's not the only one).

> 
> It'll be okay for PIPT and non-aliasing VIPT cache architectures, but
> for other cache architectures this will hide this problem and make
> review harder.
> 

Ok, you lost me. I'll have to do my homework and try to understand what
this means :).

Thanks for your valuable inputs.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
