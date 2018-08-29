From: Eugeniy.Paltsev@synopsys.com (Eugeniy Paltsev)
Date: Wed, 29 Aug 2018 18:33:53 +0000
Subject: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <1535567633.4465.23.camel@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,
Since v4.19-rc1 we are getting a serious regression on platforms with ARC architecture.
The kernel have become unstable and spontaneously crashes on LTP tests execution / IO tests or
even on boot.

I don't know exactly what breaks but bisect clearly assign the blame to this commit:
84c6591103db ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")
https://github.com/torvalds/linux/commit/84c6591103dbeaf393a092a3fc7b09510825f6b9

Reverting the commit solves this problem.

I tested v4.19-rc1 on ARM (wandboard, i.mx6, 32bit, quard core, ARMv7) which uses same
generic bitops implementation and it works fine.

Do you have any ideas what went wrong?
-- 
 Eugeniy Paltsev
