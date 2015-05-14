From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 14 May 2015 23:50:47 +0200
Subject: [PATCH] rtc: pfc8563: fix uninitialized variable warning
In-Reply-To: <2293546.ekQV1ek12O@wuerfel>
References: <2293546.ekQV1ek12O@wuerfel>
Message-ID: <20150514215047.GE3338@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 12/05/2015 at 23:27:02 +0200, Arnd Bergmann wrote :
> Gcc is unable to prove that alm_pending is always initialized
> when it is used, so it prints a harmless warning:
> 
> drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_probe':
> drivers/rtc/rtc-pcf8563.c:449:5: warning: 'alm_pending' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This uses the same conditional expression that is used inside of
> the pcf8563_get_alarm_mode() function, to help gcc figure it out
> and shut up that warning, and make the ARM defconfigs build again
> with no warnings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a45d528aab8b ("rtc: pcf8563: clear expired alarm at boot time")
> 

Can you send that fix to Linus for the next 4.1 rc?

You can add my
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

I hope that will be the last one :)

Thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
