From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 18 Apr 2018 23:24:34 +0200
Subject: Screen brightness behaves _very_ differently across different machines
Message-ID: <20180418212434.GB26962@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I tried to run auto brightness settings tuned for Nokia N900 on Droid
4, and results were not nice.

So I tried matching brightness between Nokia N900 and Droid 4, and I
have a reason:

Brightness 1 on n900 corresponds to brightness _50_ on droid 4.

| n900 |  d4 |
|    1 |  50 |
|    2 |  70 |
|    6 | 100 |
|    8 | 120 |
|   20 | 130 |
|   30 | 140 |
|   40 | 150 |
|  100 | 180 |
|  128 | 190 |
|  150 | 200 |
|  200 | 210 |
|  255 | 220 |

Values are very approximate, I did manually. (Light sensors are funny,
Nokia seems to have calibscale on intensity input, which should be
unitless, but not on illumination input, which should be in lux. And
I'm not sure... is value_in_lux = illumination_input /
illumination_scale?)

I'll get some sleep now, if you know what is going on there, let me
know...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180418/9e45a856/attachment.sig>
