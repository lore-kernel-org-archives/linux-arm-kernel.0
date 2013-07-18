From: nfortino@nvidia.com (Nickolas Fortino)
Date: Wed, 17 Jul 2013 18:48:37 -0700
Subject: preempted dup_mm misses TLB invalidate
In-Reply-To: <20130717212148.GV24642@n2100.arm.linux.org.uk>
References: <51E43D2B.9090709@nvidia.com>
 <20130717192746.GE16496@MacBook-Pro.local> <51E6F60D.6060804@wwwdotorg.org>
 <51E6FA10.5070504@nvidia.com> <20130717203409.GU24642@n2100.arm.linux.org.uk>
 <51E706A6.4040309@nvidia.com> <20130717212148.GV24642@n2100.arm.linux.org.uk>
Message-ID: <51E74975.9040105@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/17/2013 2:21 PM, Russell King - ARM Linux wrote:
> I'm
> willing to bet that the behaviour you observe on ARM is inherently visible
> on many of the other Linux architectures.

Based on the discussion from this thread, I agree there is nothing 
architecture specific here. This behavior also appears legal, so long as 
any page with write permissions in the TLB is considered dirty in the 
linux PTE structure.

I had missed the specification for fork() is silent on what happens to 
MAP_PRIVATE memory modifications which occur during the execution of 
fork(); it merely specifies what happens to writes which occur prior to 
fork being called and after fork returns.
