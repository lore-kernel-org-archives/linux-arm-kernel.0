From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 Nov 2009 17:24:46 +0000
Subject: Can anyone help test Cortex A9 patches?
In-Reply-To: <20091119090328.GC13376@n2100.arm.linux.org.uk>
References: <20091119090328.GC13376@n2100.arm.linux.org.uk>
Message-ID: <1258651486.24487.55.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-11-19 at 09:03 +0000, Russell King - ARM Linux wrote:
> I need help testing Cortex A9 patches.  What I need is someone with a
> fairly fully fledged Cortex A9 platform with the ability to build and
> test recent kernels - and therefore be able to test my patches without
> modification.
> 
> Specifically, I'm looking for someone who can reproduce data corruption
> on DMA transfers from devices caused by Cortex A9's speculative prefetching
> 
> Unfortunately, I have no way to reproduce this problem here (I have no
> Cortex A9 hardware), and as such I can't test the fixes.

I can get access to a PBX-A9 board but there is no DMA support on it, so
not able to reproduce the problem.

What's the background to this? Has anyone reported issues?

Another thing we have is domain switching overriding the NX bit on
ioremap'ed regions and therefore getting speculative prefetches from
that area (in theory, it's hard to predict what the CPU would try to
prefetch). But we don't set the manager domain for too long and it would
be hard to trigger a failure.

-- 
Catalin
