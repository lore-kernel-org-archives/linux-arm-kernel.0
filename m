From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 25 Jan 2016 12:36:50 +0200
Subject: [PATCH 07/15] dmaengine: dw: revisit data_width property
In-Reply-To: <yw1xfuxmkl19.fsf@unicorn.mansr.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-8-git-send-email-mans@mansr.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E86560@us01wembx1.internal.synopsys.com>
 <1453711547.2521.209.camel@linux.intel.com>
 <yw1xfuxmkl19.fsf@unicorn.mansr.com>
Message-ID: <1453718210.2521.219.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-01-25 at 10:31 +0000, M?ns Rullg?rd wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > On Mon, 2016-01-25 at 07:32 +0000, Vineet Gupta wrote:
> > > On Monday 25 January 2016 12:55 AM, Mans Rullgard wrote:

> > > > --- a/Documentation/devicetree/bindings/dma/snps-dma.txt
> > > > +++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
> > > > @@ -13,8 +13,7 @@ Required properties:
> > > > ?- chan_priority: priority of channels. 0 (default): increase
> > > > from
> > > > chan 0->n, 1:
> > > > ???increase from chan n->0
> > > > ?- block_size: Maximum block size supported by the controller
> > > > -- data_width: Maximum data width supported by hardware per AHB
> > > > master
> > > > -??(0 - 8bits, 1 - 16bits, ..., 5 - 256bits)
> > > > +- data-width: Maximum data width supported by hardware (in
> > > > bytes)
> > > 
> > > To the reader this suggests a value truely byte granular, but
> > > code
> > > uses ffs
> > > implying that it is still power of 2.
> > > Can you mention this here (....in bytes, always power of 2).
> > 
> > While this comment is good, I have still note that using non-power
> > of 2
> > values will not break anything. Least power of two number will be
> > used
> > in that case. So, means I would suggest to replace 'always' by
> > 'better
> > to be' or something like that.
> 
> Although the code rounds down, the hardware actually works in powers
> of
> two, and it's better to document this.

Let's do "(in bytes, power of 2)" then?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
