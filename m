From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Oct 2013 19:00:59 +0100
Subject: [RFC 06/23] mm/memblock: Add memblock early memory allocation apis
In-Reply-To: <20131013175648.GC5253@mtj.dyndns.org>
References: <1381615146-20342-1-git-send-email-santosh.shilimkar@ti.com>
 <1381615146-20342-7-git-send-email-santosh.shilimkar@ti.com>
 <20131013175648.GC5253@mtj.dyndns.org>
Message-ID: <20131013180058.GG25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 13, 2013 at 01:56:48PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Sat, Oct 12, 2013 at 05:58:49PM -0400, Santosh Shilimkar wrote:
> > Introduce memblock early memory allocation APIs which allow to support
> > LPAE extension on 32 bits archs. More over, this is the next step
> 
> LPAE isn't something people outside arm circle would understand.
> Let's stick to highmem.

LPAE != highmem.  Two totally different things, unless you believe
system memory always starts at physical address zero, which is very
far from the case on the majority of ARM platforms.

So replacing LPAE with "highmem" is pure misrepresentation and is
inaccurate.  PAE might be a better term, and is also the x86 term
for this.
