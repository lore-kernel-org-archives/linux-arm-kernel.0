From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 22 Aug 2009 14:04:29 +0200 (MEST)
Subject: [RFC/RFT 0/3] iop: convert to generic time
Message-ID: <200908221204.n7MC4Tuh029333@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches converts the ARM kernel's XScale IOP
platform to use the kernel's generic clocksource, clockevent,
and time-keeping code. My goal with this is in part to align
the IOP code with current kernel practices, but ultimately I
want to enable NOHZ mode.

This is my first attempt to write clocksource/clockevent code,
so I'd appreciate if those with experience in that area could
review this. I'm especially uncertain about what to put in the
`.shift' fields in the clocksource and clockevent structures.

Runtime tested on a Thecus n2100 (iop32x). Survives both heavy
CPU load (gcc recompile) and idle conditions without hickups or
lost time. However, I can't seem to get the kernel to actually
engage NOHZ mode, so something is still missing.

Compile-tested for all iop13xx/iop32x/iop33x platforms.

/Mikael
