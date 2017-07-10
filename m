From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 10 Jul 2017 09:46:11 +0200
Subject: 4.13-rc0: stopped booting on Nokia N900
Message-ID: <20170710074610.GA22846@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

First, I got segfault from make:

: 0: Can't open
scripts/Makefile.build:561: recipe for target
'drivers/iio/imu/st_lsm6dsx' failed
make[3]: *** [drivers/iio/imu/st_lsm6dsx] Segmentation fault (core
dumped)
scripts/Makefile.build:561: recipe for target 'drivers/iio/imu' failed
make[2]: *** [drivers/iio/imu] Error 2
scripts/Makefile.build:561: recipe for target 'drivers/iio' failed
make[1]: *** [drivers/iio] Error 2
make[1]: *** Waiting for unfinished jobs....
Makefile:1008: recipe for target 'drivers' failed
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....
pavel at duo:/data/l/linux-n900$ ./mkit

Then compile worked, but it failed to boot. I've now cleaned caches
and am rebuilding to make sure it is not build machine that has
glitches.

No such luck :-(.

I tested linux-next relatively recently, and it worked ok.

af3c8d98508d37541d4bf57f13a984a7f73a328c is broken.
650fc87 worked ok.

Best regards,

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170710/a626bfb6/attachment.sig>
