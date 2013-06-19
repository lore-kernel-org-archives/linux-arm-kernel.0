From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jun 2013 09:28:40 +0100
Subject: [PATCH 1/2] ARM: mmu: fix the hang when we steal a section
 unaligned size memory
In-Reply-To: <51C11916.2030807@freescale.com>
References: <1371113826-1231-1-git-send-email-b32955@freescale.com>
 <20130618152905.GB8534@mudshark.cambridge.arm.com>
 <20130618165246.GC2718@n2100.arm.linux.org.uk>
 <51C11916.2030807@freescale.com>
Message-ID: <20130619082840.GG2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 10:36:06AM +0800, Huang Shijie wrote:
> ? 2013?06?19? 00:52, Russell King - ARM Linux ??:
>> This is why I've always said - if you steal memory from memblock, it
>> _must_  be aligned to 1MB (the section size) to avoid this.  Not only
>
> firstly, it's a little waste to _must_ steal 1M for some board with less  
> memory such as 512M memory;

You're complaining about 512M memory?  Christ.  Some of my machines
which I run here have as little as 32M of memory!  1M is nothing in
512M.

> secondly, if we do not support the section unaligned mapping, we should  
> remove the alloc_init_pte() in alloc_init_pmd(),
> add a comment to tell that we do not support the section unaligned mapping.

No, because that breaks a whole load of other non-memory mappings.
