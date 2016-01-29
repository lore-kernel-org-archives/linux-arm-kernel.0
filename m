From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 29 Jan 2016 16:55:08 +0100
Subject: [PATCH 1/7] usb: gadget: pxa25x_udc: move register definitions
 from arch
In-Reply-To: <1453997843-3489728-1-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Thu, 28 Jan 2016 17:17:02 +0100")
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-1-git-send-email-arnd@arndb.de>
Message-ID: <m3h9hwgz37.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> This addresses both issues by moving all the definitions into the
> pxa25x_udc driver itself. It turns out the only difference between
> them was 'UDCCS_IO_ROF', and that could well be a mistake when it
> was incorrectly copied from pxa25x to ixp4xx.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Both the programming manual and the Intel's library code say it's
bit 2. Must be a mistake in the old code. Unfortunately I think we
won't be able to check it on real hardware, the UDC on IXP4xx boards
isn't usually connected. Also, this bug wouldn't likely affect
operation (unless there is an overflow event, which would be
currently undetected).

I guess we as well very safely change it to 1 << 2.


For the IXP4xx part,
Acked-by: Krzysztof Halasa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
