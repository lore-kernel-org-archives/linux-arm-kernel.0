From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Mar 2011 12:07:48 +0000
Subject: Why don't we have atomic_set_mask()?
In-Reply-To: <AANLkTi=V5mHHibKftXZ1A+s6xiuqH5X0pqYPMjZod6EV@mail.gmail.com>
References: <AANLkTi=V5mHHibKftXZ1A+s6xiuqH5X0pqYPMjZod6EV@mail.gmail.com>
Message-ID: <20110317120748.GH29758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 08:36:15PM +0900, KyongHo Cho wrote:
> arch/arm/asm/atomic.h defines atomic_clear_mask() but its counterpart,
> atomic_set_mask() is not defined.

Nothing other than some s390 drivers seems to use it, so I'd say no.
I also feel that atomic_xxx() is over-used, many times in inappropriate
and buggy ways.

If you want to manipulate bitmasks or bitmaps, then imho you should be
using the bitops or bitmap support rather than atomic stuff.
