From: bryan.wu@canonical.com (Bryan Wu)
Date: Fri, 14 Jan 2011 06:34:30 +0800
Subject: mmaping a fixed address fails on ARM
In-Reply-To: <20110113112552.GA26828@n2100.arm.linux.org.uk>
References: <AANLkTin0jjxLTWzkLHnJ+sGQz=jdDDL94R9o1gh-rO9P@mail.gmail.com>
	<20110113112552.GA26828@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim6MZyBzwwdiNMkzMsa3hTV2mC_HWwRmnbzLYtK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 7:25 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 13, 2011 at 05:58:01AM +0800, Bryan Wu wrote:
>> The implementation of arch_get_unmapped_area() is different from ARM
>> and x86, that might makes mmap behavior different between ARM and x86.
>> Andre said 2.6.28-versatile. I'm not sure whether it is a regression.
>
> For the same conditions (iow, same mapping) on ARMv7 and ARMv5-only
> kernels vs x86 the results will be the same. ?On ARMv6-supporting kernels
> we have aliasing caches to deal with where we intentionally force the
> alignment of non-MAP_FIXED mappings.
>

Right, ARMv6 code is different in arch_get_unmapped_area() code from
others. The different results from x86 is because of some address was
mapped to libraries as Sebastien reported.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
