From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Tue, 22 Apr 2014 10:28:05 +0000
Subject: [PATCH v1] dma: imx-sdma: add support for sdma memory copy
In-Reply-To: <20140418094057.GA11496@Robin-OptiPlex-780>
References: <1397728870-22086-1-git-send-email-b38343@freescale.com>
 <1397730289.11914.225.camel@smile.fi.intel.com>
 <20140418094057.GA11496@Robin-OptiPlex-780>
Message-ID: <1398162484.11914.234.camel@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-04-18 at 17:41 +0800, Robin Gong wrote:
> On Thu, Apr 17, 2014 at 10:24:50AM +0000, Shevchenko, Andriy wrote:
> > On Thu, 2014-04-17 at 18:01 +0800, Robin Gong wrote:

[]

> > > +	dev_dbg(sdma->dev, "memcpy: %x->%x, len=%d, channel=%d.\n",
> > 
> > %pad for dma_addr_t variables.
> >
> Yes, %x here is not proper, will be %#llx here to align with others similar
> code in this file.

Why %#llx? You don't need the specific casting since kernel has special
specifiers for phys_addr_t and dma_addr_t and their derivatives (see
Documentation/printk-formats.txt)

> > > +		dev_dbg(sdma->dev, "entry %d: count: %d dma: 0x%08x %s%s\n",
> > > +				i, count, sg_src->dma_address,
> > 
> > %pad for dma_addr_t.
> > 
> Accept the idea, same as the above.

Same as above.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
