From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 29 Nov 2009 09:37:32 +0100
Subject: [PATCH] ARM: gta02: Add vibrator support
In-Reply-To: <1259377532-8012-4-git-send-email-lars@metafoo.de>
References: <1259377532-8012-1-git-send-email-lars@metafoo.de>
	<1259377532-8012-2-git-send-email-lars@metafoo.de>
	<1259377532-8012-3-git-send-email-lars@metafoo.de>
	<1259377532-8012-4-git-send-email-lars@metafoo.de>
Message-ID: <20091129083731.GC1530@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> The vibrator found on the gta02 is controlled by the s3c pwm controller.
> Instead of writing a special vibrator driver/class the vibrator is represented
> as a led device.

Maybe vibrator device will be needed after all?

1) it is getting very common

2) timed-gpio model makes more sense for vibrators -- send 200msec
pulse

3) normal triggers make little sense. 'vibrate when battery charges'
is cool hack, but

4) can vibrator motor survive running 24/7 ?

5) it is really force feedback; we have input handling for that. Is it
unusable?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
