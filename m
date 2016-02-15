From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 15 Feb 2016 08:07:35 +0100
Subject: [PATCH 2/3] ARM: ixp4xx: avoid warning about ioport_map() macro
 argument processing
In-Reply-To: <1454689262-613421-2-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Fri, 5 Feb 2016 17:20:49 +0100")
References: <1454689262-613421-1-git-send-email-arnd@arndb.de>
 <1454689262-613421-2-git-send-email-arnd@arndb.de>
Message-ID: <m3io1qbgeg.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> We get a harmless compiler warning when building the cs89x0 driver
> for ixp4xx:
>
> drivers/net/ethernet/cirrus/cs89x0.c: In function 'cs89x0_ioport_probe':
> drivers/net/ethernet/cirrus/cs89x0.c:1602:28: warning: suggest parentheses around '+' in operand of '&' [-Wparentheses]
>   io_mem = ioport_map(ioport & ~3, NETCARD_IO_EXTENT);
>
> Simply adding parentheses in the macro avoids the warning
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ixp4xx/include/mach/io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Ha?asa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
