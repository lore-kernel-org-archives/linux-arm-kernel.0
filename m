From: Harald.Krammer@hkr.at (Harald Krammer)
Date: Mon, 03 Jan 2011 09:31:27 +0100
Subject: SRAM performance optimization (PXA270)
Message-ID: <4D21895F.9090807@hkr.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I am currently running a PXA270 520MHz system with a 104 MHz DRAM. Now I
need to optimize my system. The analysis showed me (with the help of
valgrind, gettimeofday, size,...) that a poor cache hit rate is present.
So I came to the conclusion that the SRAM will help me, because it is
clocked with 208 MHz.

Now the question: how?

My first test was to map few data of my application into the SRAM via
the mmap system call and so I got a performance boost of ~4%.  I know
from my tests that the code-cache hit rate is poor too, so the code
should be placed into the SRAM. How I can do that?
My current idea is to write a so-library with code and load it into the
SRAM.  The effort looks a little bit complex and  the disadvantages are
debugging and  core file analysis (gdb needs also patches). So in case
of any problems in the code it will be hard to find it.
BTW, -fPIC code (position-independent code) costs around 3 % performance
in my case. I have never thought about that, but it is logical.

Exists better solution?
e.g. fixed map-address with modified loader ?, or exists a kernel patch
to locate few parts of the kernel into SRAM?

Thanks for any ideas or comments
Nice greetings
Harald

-- 

Harald Krammer

Mobil +43.(0) 664. 130 59 58
Mail: Harald.Krammer (at) hkr.at
