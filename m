From: viresh.linux@gmail.com (viresh kumar)
Date: Thu, 16 Feb 2012 08:41:02 -0800
Subject: Query: Multiple Mappings to Mem and ARMV6+
Message-ID: <CAOh2x=nT365ixeHKsV7-313ZbKMoVLj0bEr9BvKB7jdGSnMV8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

Sorry for starting the long old thread again, but i have to start it as i
was a bit confused. :(

We know that we can't have multiple mappings with different attributes
to the same physical memory on ARMv6+ machines due to speculative
prefetch.

So, we have following kind of mappings in kernel now (please correct me
if i am wrong):
- Low Mem: Mapped at boot time to - Normal Cacheable - Bufferable
- ioremap() - blocked on Low Mem, so that we don't create Device type mapping
to same mem
- dma_alloc_coherent() and others:
         - Without DMA_MEM_BUFFERABLE selected - gives strongly ordered mem
          (i.e. Non cacheable - Non Bufferable)
         - With DMA_MEM_BUFFERABLE selected - gives Normal - Non cacheable -
           Bufferable mapping
         - Maybe some other too...

I have a doubt with the last mapping mentioned above. We have two mappings
possibly to the same physical memory, with different attributes: One
is Cacheable
and other one is not.

Is this allowed by ARM? Because the patch in which Russell blocked ioremap on
Low Mem, he clearly mentioned that these attributes are also important and they
should be same.

Sorry if i am missing something :)

--
viresh
