From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Oct 2014 22:13:52 +0200
Subject: [PATCH v6] ARM: clocksource: add asm9260_timer driver
In-Reply-To: <1413539165-3801-1-git-send-email-linux@rempel-privat.de>
References: <543EE79F.6080504@gmail.com>
 <1413539165-3801-1-git-send-email-linux@rempel-privat.de>
Message-ID: <2408781.4RxqBFiRXu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 October 2014 11:46:05 Oleksij Rempel wrote:
> +CLOCKSOURCE_OF_DECLARE(asm9260_timer, "alphascale," DRIVER_NAME,
> +               asm9260_timer_init);
> 

Please avoid the use of the DRIVER_NAME macro here, it makes it
very hard to grep for uses of the compatible string.

You forgot to put Daniel Lezcano <daniel.lezcano@linaro.org> on Cc
for the submission.

	Arnd
