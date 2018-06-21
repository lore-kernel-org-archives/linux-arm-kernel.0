From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 21 Jun 2018 14:15:42 +0200
Subject: v4.18-rc1 on droid 4: very bad CPU performance
Message-ID: <20180621121542.GA4836@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

V4.18 is slower than it should be.

user at devuan:~$ time cat /dev/urandom | head -c 10000000 |  bzip2 -9 -
| wc -c
10044291
52.73user 2.40system 61.53 (1m1.534s) elapsed 89.60%CPU
user at devuan:~$ uname -a
Linux devuan 4.18.0-rc1-87964-gfa19934-dirty #743 SMP Sun Jun 17
19:26:37 CEST 2018 armv7l GNU/Linux

That bzip should take 12 seconds, not minute.

Any ideas? Do you see it, too?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180621/aae8df5a/attachment.sig>
