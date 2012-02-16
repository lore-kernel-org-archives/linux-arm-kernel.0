From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Feb 2012 17:29:28 +0000
Subject: Query: Multiple Mappings to Mem and ARMV6+
In-Reply-To: <20120216172242.GH27825@n2100.arm.linux.org.uk>
References: <CAOh2x=nT365ixeHKsV7-313ZbKMoVLj0bEr9BvKB7jdGSnMV8w@mail.gmail.com>
 <20120216171520.GA9151@arm.com>
 <20120216172242.GH27825@n2100.arm.linux.org.uk>
Message-ID: <20120216172928.GD9151@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 05:22:42PM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 16, 2012 at 05:15:20PM +0000, Catalin Marinas wrote:
> > On Thu, Feb 16, 2012 at 04:41:02PM +0000, viresh kumar wrote:
> > > Sorry for starting the long old thread again, but i have to start it as i
> > > was a bit confused. :(
> > > 
> > > We know that we can't have multiple mappings with different attributes
> > > to the same physical memory on ARMv6+ machines due to speculative
> > > prefetch.
> > > 
> > > So, we have following kind of mappings in kernel now (please correct me
> > > if i am wrong):
> > > - Low Mem: Mapped at boot time to - Normal Cacheable - Bufferable
> > > - ioremap() - blocked on Low Mem, so that we don't create Device type mapping
> > > to same mem
> > > - dma_alloc_coherent() and others:
> > >          - Without DMA_MEM_BUFFERABLE selected - gives strongly ordered mem
> > >           (i.e. Non cacheable - Non Bufferable)
> > >          - With DMA_MEM_BUFFERABLE selected - gives Normal - Non cacheable -
> > >            Bufferable mapping
> > >          - Maybe some other too...
> > > 
> > > I have a doubt with the last mapping mentioned above. We have two
> > > mappings possibly to the same physical memory, with different
> > > attributes: One is Cacheable and other one is not.
> > > 
> > > Is this allowed by ARM? Because the patch in which Russell blocked
> > > ioremap on Low Mem, he clearly mentioned that these attributes are
> > > also important and they should be same.
> > 
> > Section A3.5.7 in the latest ARM ARM (revC) clarifies the mismatched
> 
> There's a new version?

Rev C has been available for a while. I thought you got it already:

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0406c/index.html

It contains the LPAE and virtualisation extensions.

-- 
Catalin
