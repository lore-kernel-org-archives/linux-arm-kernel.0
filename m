From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Jul 2014 23:17:55 +0200
Subject: [PATCH ] ARM: pxa: fix section mismatch warning for
 pxa_timer_nodt_init
In-Reply-To: <12220413.BdRleC0Xf5@wuerfel> (Arnd Bergmann's message of "Sat,
 26 Jul 2014 20:50:36 +0200")
References: <1405356724-32207-1-git-send-email-robert.jarzmik@free.fr>
 <53CD25A4.7030606@linaro.org> <87oawivarv.fsf@free.fr>
 <12220413.BdRleC0Xf5@wuerfel>
Message-ID: <871tt7om4c.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> commit a38b1f60b5245a3 ("ARM: pxa: Add non device-tree timer link to
> clocksource") introduced a harmless section mismatch warning for
> all pxa platforms, by introducing a new pxa_timer_init() function
> that is not marked __init but that calls pxa_timer_nodt_init(),
> which is. The function is only called at init time, so it is safe
> to also annotate it this way.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Indeed.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
