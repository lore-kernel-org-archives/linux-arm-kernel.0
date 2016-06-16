From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 16 Jun 2016 19:56:38 +0200
Subject: [PATCH 4/5] usb: pxa27x_udc: remove unused function argument
In-Reply-To: <20160616113831.4108439-5-arnd@arndb.de> (Arnd Bergmann's message
 of "Thu, 16 Jun 2016 13:38:25 +0200")
References: <20160616113831.4108439-1-arnd@arndb.de>
 <20160616113831.4108439-5-arnd@arndb.de>
Message-ID: <877fdp9fvt.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> We get a warning for this when building with W=1 because the
> argument gets assigned to something else but never read:
>
> drivers/usb/gadget/udc/pxa27x_udc.c: In function 'stop_activity':
> drivers/usb/gadget/udc/pxa27x_udc.c:1828:74: error: parameter 'driver' set but not used [-Werror=unused-but-set-parameter]
>
> This remove the argument entirely.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Hi Arnd,

I wonder if it'd worth adding this ... even if the word "Completes" would be more
correct than "Fixes" :
Fixes: 70189a63d408 ("usb: gadget: pxa27x_udc: convert to udc_start/udc_stop")

Apart form that:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
