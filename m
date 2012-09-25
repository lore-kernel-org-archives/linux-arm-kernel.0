From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 25 Sep 2012 21:43:39 +0200
Subject: PXA PWM possible regression after 3.5: backlight remains off
 after resume
In-Reply-To: <505F5151.5070506@yahoo.com> (Paul Parsons's message of "Sun, 23
 Sep 2012 19:13:37 +0100")
References: <505F28B8.1030701@yahoo.com>
 <20120923172232.GA1293@avionic-0098.mockup.avionic-design.de>
 <505F5151.5070506@yahoo.com>
Message-ID: <87ehlpzy50.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Parsons <lost.distance@yahoo.com> writes:

> The same failure is also present in 3.6-rc1.
>
> Just to be clear, are you saying that drivers/pwm/pwm-pxa.c should
> include suspend/resume handlers like in drivers/pwm/pwm-samsung.c ?
>
> Agreed that it is possible that recent changes exposed a latent bug
> somewhere, and that turning the backlight on after resume should never
> have worked.

Hi Paul,

I checked on the mioa701 board (see [1]).
On my board, the backlight if fully driven by PXA PWM0, and the suspend/resume
is working perfectly.

So I don't thing anything is needed for suspend/resume wrt PWM (empirically).

Cheers.

-- 
Robert

[1]
$ cat /sys/class/backlight/pwm-backlight/actual_brightness 
50
$ cat /sys/class/backlight/pwm-backlight/actual_brightness 
50
$ echo 90 > /sys/class/backlight/pwm-backlight/brightness        
$ echo mem > /sys/power/state 
$ 
$ cat /sys/class/backlight/pwm-backlight/actual_brightness 
90
$ uname -a
Linux mioa701 3.6.0-rc6+ #26 PREEMPT Sat Sep 22 22:08:41 CEST 2012 armv5tel unknown
