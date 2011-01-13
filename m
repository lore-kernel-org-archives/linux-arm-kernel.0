From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jan 2011 11:25:52 +0000
Subject: mmaping a fixed address fails on ARM
In-Reply-To: <AANLkTin0jjxLTWzkLHnJ+sGQz=jdDDL94R9o1gh-rO9P@mail.gmail.com>
References: <AANLkTin0jjxLTWzkLHnJ+sGQz=jdDDL94R9o1gh-rO9P@mail.gmail.com>
Message-ID: <20110113112552.GA26828@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 05:58:01AM +0800, Bryan Wu wrote:
> The implementation of arch_get_unmapped_area() is different from ARM
> and x86, that might makes mmap behavior different between ARM and x86.
> Andre said 2.6.28-versatile. I'm not sure whether it is a regression.

For the same conditions (iow, same mapping) on ARMv7 and ARMv5-only
kernels vs x86 the results will be the same.  On ARMv6-supporting kernels
we have aliasing caches to deal with where we intentionally force the
alignment of non-MAP_FIXED mappings.
