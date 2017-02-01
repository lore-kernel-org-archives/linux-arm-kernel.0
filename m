From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed, 01 Feb 2017 13:20:53 +0100
Subject: [RESENT PATCH] ARM: bcm2835: Add devicetree for the Raspberry
 Pi 3, for arm (32)
In-Reply-To: <1485944672.1076.50.camel@redhat.com>
References: <1484845444-4617-1-git-send-email-kraxel@redhat.com>
 <87fukcgsqp.fsf@eliezer.anholt.net> <878tpqki0k.fsf@eliezer.anholt.net>
 <1485944672.1076.50.camel@redhat.com>
Message-ID: <1485951653.1076.54.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I think just having links from
> > arch/arm64/boot/dts/broadcom/bcm2837*.dts* to arch/arm/boot/dts/ would
> > be the solution, then this Makefile could just reference
> > bcm2837-rpi-3-b.dtb.
> 
> I suspect it is not that easy, last time I tried it didn't work.
> Will try again though.

Yep, dtbs_install fails:

[ ... ]
  INSTALL arch/arm/boot/dts/bcm2835-rpi-b-plus.dtb
  INSTALL arch/arm/boot/dts/bcm2835-rpi-a-plus.dtb
  INSTALL arch/arm/boot/dts/bcm2836-rpi-2-b.dtb
  INSTALL 
cp: missing destination file operand after '/boot/dtbs/4.10.0-rc5+'
Try 'cp --help' for more information.
/root/linux/scripts/Makefile.dtbinst:41: recipe for target
'bcm2837-rpi-3-b.dts' failed
make[3]: *** [bcm2837-rpi-3-b.dts] Error 1
arch/arm/Makefile:348: recipe for target 'dtbs_install' failed
make[2]: *** [dtbs_install] Error 2
Makefile:150: recipe for target 'sub-make' failed
make[1]: *** [sub-make] Error 2
Makefile:24: recipe for target '__sub-make' failed
make: *** [__sub-make] Error 2

cheers,
  Gerd
