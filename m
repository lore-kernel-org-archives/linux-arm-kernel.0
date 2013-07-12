From: jjo.braun@gmail.com (Johannes Braun)
Date: Fri, 12 Jul 2013 10:19:16 +0200
Subject: Freescale i.MX351: Poor framebuffer performance with 7 inch display
Message-ID: <CADwvPCsm4UEGLH_mfpeoZ7L-wSTqTgicYXd6+_YuFSxGy57o2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear mailing list,

our current board design is based on a freescale i.MX35 processor.
First some information to the used arm processor. It is an i.MX351 and
its core is clocked to 523Mhz. We have connected a 7 inch display with
a resolution of 800x480 pixels directly to the arm. The display is
working but the performance with qt embedded is very poor. When the
complete display content changes, e.g. from red to green or from blue
to black, there is a bad "wipe effect". The new display content wipes
from the top down to the bottom of the display.

To test the performance without qt embedded I wrote a small c program
which writes a color array directly to the framebuffer device
(/dev/fb0). This program updates the complete framebuffer content
every second. From red to green, from green to blue, from blue to
black and so on. The "wipe effect" is also visible. But less
pronounced than with qt embedded. Shure qt embedded decreases the
performance, but I don`t think this is the core issue for my
performance problems.

There is another point I noticed. The defaut bpp (bit per pixel) value
in the driver is 16. Changing the drivers bpp up to 32 decreases the
performance rapidly. To change the bpp I used the kernel parameter
video=mx3fb:bpp=32.

So I think the core issue is either the performace of the arm itself,
the ram throughput or the driver mx3fb.c. Maybe someone who uses a
similar design could share some information about the performance of
this design. Also I will be gratefull for hints to increase my
performance or to find the bottleneck.

Thanks.


---
Johannes
