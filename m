From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 4 May 2010 06:14:48 +0200
Subject: 2.6.34-rc6 regression: pcmcia no longer compiles
Message-ID: <20100504041448.GA2893@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

-rc5 compiled ok with similar config.

Now I get:

  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      drivers/pcmcia/pcmcia_ioctl.o
drivers/pcmcia/pcmcia_ioctl.c: In function 'ds_open':
drivers/pcmcia/pcmcia_ioctl.c:714: error: 'struct <anonymous>' has no member named 'present'
drivers/pcmcia/pcmcia_ioctl.c: In function 'ds_read':
drivers/pcmcia/pcmcia_ioctl.c:773: error: 'struct <anonymous>' has no member named 'dead'
drivers/pcmcia/pcmcia_ioctl.c: In function 'ds_ioctl':
drivers/pcmcia/pcmcia_ioctl.c:841: error: 'struct <anonymous>' has no member named 'dead'
make[2]: *** [drivers/pcmcia/pcmcia_ioctl.o] Error 1
make[1]: *** [drivers/pcmcia] Error 2
make: *** [drivers] Error 2


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
