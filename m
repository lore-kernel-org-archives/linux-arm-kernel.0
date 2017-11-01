From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 1 Nov 2017 07:36:55 +0100
Subject: Nokia N9: fun with camera
In-Reply-To: <20171031212812.GA11148@amd>
References: <20170424212914.GA20780@amd> <20170424224724.5bb52382@vento.lan>
 <20170426105300.GA857@amd> <20170426082608.7dd52fbf@vento.lan>
 <20171021220026.GA26881@amd>
 <f85cab54-30cf-0774-7376-abced86842af@xs4all.nl>
 <20171023185414.GA2258@amd>
 <40C85971-7DDE-4FB0-AB90-C52CA864C0D4@xs4all.nl>
 <20171023201557.hecu4e6o3ynp5hmv@valkosipuli.retiisi.org.uk>
 <20171031212812.GA11148@amd>
Message-ID: <20171101063655.GA16895@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Sakari, I am actually playing with N9 camera, not N950. That comes
> next.
> 
> And the clock error I mentioned ... seems to be
> -EPROBE_DEFER. So... not an issue.

Hmm, and with similar config, I got N950 to work. ... which should
give me enough clues to get N9 to work. I guess I forgot to reset the
pipeline between the tries, or something.

For the record, this got me some data on n950:

 m.media_ctl( [ '-f', '"OMAP3 ISP CSI2a":0 [fmt:%s/%dx%d]' % (m.fmt, m.cap_x, m.cap_y) ] )
 m.media_ctl( [ '-l', '"OMAP3 ISP CSI2a":1 -> "OMAP3 ISP CSI2a output":0[1]' ] )

 # WORKS!!!!
 # pavel at n900:~/g/tui/camera$ sudo /my/tui/yavta/yavta
 # --capture=8 --skip 0 --format SGRBG10 --size 4272x3016 /dev/video1 --file=/tmp/delme#

...ouch. It only worked twice :-(. Either driver gets confused by my
attempts, or it relied on some other initialization code. Strange.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171101/6e31e864/attachment.sig>
