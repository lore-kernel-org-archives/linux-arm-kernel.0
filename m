From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Apr 2010 22:36:19 +0100
Subject: [PATCH 0/6] ARM: pmu: provide a registration mechanism for
	IRQs [v3]
In-Reply-To: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
References: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
Message-ID: <20100428213619.GA16525@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 03:16:32PM +0000, Will Deacon wrote:
> This is version 3 of the patch series originally posted here:
> 
> v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011162.html
> v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011339.html

Unfortunately, these patches are inter-dependent - if I apply the
realview patch to my 'versatile' branch without the first patch, then
it breaks the realview build because ARM_PMU_DEVICE_CPU is not defined.

But if I apply the first patch initially, everything using the new
PMU infrastructure breaks until the other patches are applied.

Please can we have an ordered set which doesn't break compilation.
What I think should happen is the first patch should introduce the
new definitions required for the platform data, and the rest of the
first patch should come at the very end.

Thanks.
