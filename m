From: geoff@infradead.org (Geoff Levand)
Date: Fri, 08 Aug 2014 17:30:00 -0700
Subject: arm64 spin-table cpu-return-addr
Message-ID: <1407544200.8971.138.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Regarding adding a cpu-return-addr property to the spin-table
cpu enable method for arm64, we need to decide how to handle
a difference in endian mode between the kernel and the
spin-table code.

Will the spin-table code always be built as little endian?  If
so, then either the kernel or the spin code could handle this
difference, and we need to decide which will do it.  If not,
then the only way is for the spin code to do it as the kernel
has no way to tell endian mode of the spin code, unless to test
and save how it was entered at startup.

Let me know your thoughts.

-Geoff
