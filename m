From: davem@davemloft.net (David Miller)
Date: Thu, 26 May 2016 12:43:44 -0700 (PDT)
Subject: [PATCH 01/23] all: syscall wrappers: add documentation
In-Reply-To: <20160526142057.GA7456@e104818-lin.cambridge.arm.com>
References: <6407614.fdv5XFSBue@wuerfel>
 <20160525.142821.1719403997976778673.davem@davemloft.net>
 <20160526142057.GA7456@e104818-lin.cambridge.arm.com>
Message-ID: <20160526.124344.1660236473079504674.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 26 May 2016 15:20:58 +0100

> We can solve (a) by adding more __SC_WRAP annotations in the generic
> unistd.h.
 ...

I really think it's much more robust to clear the tops of the registers
by default.  Then you won't be auditing constantly and adding more and
more wrappers.

You can't even quantify the performance gains for me in any precise
way.  Whatever you gain by avoiding the 64-bit
decompostion/reconstitution for those few system calls with 64-bit
registers, you are losing by calling the wrappers for more common
system calls, more often.

"it's more natural to pass 64-bit values in a register" is not a clear
justification for this change.

This looks way over engineered to me.
