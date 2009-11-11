From: tbm@cyrius.com (Martin Michlmayr)
Date: Wed, 11 Nov 2009 15:29:48 +0000
Subject: osd_initiator.c fails to build on ARM with old ABI
Message-ID: <20091111152948.GA3601@deprecation.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I just tried to build the OSD SCSI drivers using the versatile defconfig
and got a build failure.  While investigating why it fails since it
previously built fine for me after adding the fix from
http://marc.info/?l=linux-scsi&m=125795248206756&w=2 I noticed that the
defconfig used the old ABI.

As it turns out, the failure shows up with -mabi=apcs-gnu:

(lenny)9655:tbm at em64t: ~/scratch/linux-2.6] arm-linux-gnueabi-gcc -c -mabi=apcs-gnu osd_initiator.i
osd_initiator.i: In function 'build_test':
osd_initiator.i:14644: error: negative width in bit-field '<anonymous>'
osd_initiator.i:14645: error: negative width in bit-field '<anonymous>'
(lenny)9656:tbm at em64t: ~/scratch/linux-2.6] arm-linux-gnueabi-gcc -c osd_initiator.i
(lenny)9657:tbm at em64t: ~/scratch/linux-2.6]

Maybe someone wants to investigate this.

BTW, why does the versatile defconfig not set EABI?
-- 
Martin Michlmayr
http://www.cyrius.com/
