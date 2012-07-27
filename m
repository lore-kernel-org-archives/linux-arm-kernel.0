From: dczarn@o2.pl (Damian Czarnecki)
Date: Fri, 27 Jul 2012 15:10:51 +0000 (UTC)
Subject: PXA 26x GPIO possible regression in kernel 3.3 and newer
Message-ID: <loom.20120727T164936-412@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello. This is my first post here. I have a problem with GPIOs on my board (HTC 
Blue Angel PDA) with kernel versions 3.3 and newer.
This board has PXA 263 CPU, which has 89 GPIOs
and ASIC3 chip with GPIOs 192-255.
The problem is that on kernel 3.3+ I can't access PXA GPIOs at all,
but the ASIC3 works.
Unfortunately, because of that I can't see whole kernel output or post dmesg 
here,
because PXA  GPIOs are needed for SD Card,USB and many more things.
But I caught a line "gpiochip_add: registered GPIOs 192 to 255 on device: asic3",
so it shows that  ASIC3 really is detected and works.
Other errors are "gpio-keys failed to request gpio 0 error -22",
"tmio-mmc: probe of tmio-mmc failed with error -22".
With kernel 3.2 or older everything works. When requesting PXA GPIOs, it fails.
Reading GPIOs hangs the system. I hope that somebody can help me.
I know I haven't shown much info, but this is probably all I can get now.
