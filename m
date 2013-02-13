From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Feb 2013 11:00:45 +0000
Subject: Cortex-A15 MM patches
In-Reply-To: <20130213084117.GA6356@verge.net.au>
References: <20130213084117.GA6356@verge.net.au>
Message-ID: <20130213110045.GA12685@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Feb 13, 2013 at 08:41:17AM +0000, Simon Horman wrote:
> I would like to enquire about the status of two patches which I believe
> were part of TC2 Evaluation Build which uses commit
> 7d80417ef67d51db15d5e72ac336aa6e0586014f of linaro-tracking.git.
> 
>   http://releases.linaro.org/12.10/android/vexpress
> 
> 1. ARM: LPAE: Invalidate the TLB for module addresses during translation fault
> 
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086036.html

Another variant has been proposed:

http://marc.info/?l=linux-arch&m=134858482615574&w=2

Unfortunately I haven't got any feedback.

Linaro should use the new patch instead of the old one so that it gets
wider test coverage.

> 2. ARMv7: Do not clean the PTE if coherent page table walk is supported
> 
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2011-July/055379.html

That's a valid patch but IIRC Russell wanted to cover the pmd as well. I
think it's better to include such patch if it makes a significant
difference in performance. I haven't done any benchmarks.

-- 
Catalin
