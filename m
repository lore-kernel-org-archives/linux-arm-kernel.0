From: b32955@freescale.com (Huang Shijie)
Date: Wed, 19 Jun 2013 10:36:06 +0800
Subject: [PATCH 1/2] ARM: mmu: fix the hang when we steal a
 section	unaligned size memory
In-Reply-To: <20130618165246.GC2718@n2100.arm.linux.org.uk>
References: <1371113826-1231-1-git-send-email-b32955@freescale.com>
 <20130618152905.GB8534@mudshark.cambridge.arm.com>
 <20130618165246.GC2718@n2100.arm.linux.org.uk>
Message-ID: <51C11916.2030807@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?06?19? 00:52, Russell King - ARM Linux ??:
> This is why I've always said - if you steal memory from memblock, it
> _must_  be aligned to 1MB (the section size) to avoid this.  Not only

firstly, it's a little waste to _must_ steal 1M for some board with less 
memory such as 512M memory;

secondly, if we do not support the section unaligned mapping, we should 
remove the alloc_init_pte() in alloc_init_pmd(),
add a comment to tell that we do not support the section unaligned mapping.

thanks
Huang Shijie
