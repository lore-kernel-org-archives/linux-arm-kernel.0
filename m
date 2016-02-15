From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 15 Feb 2016 08:05:54 +0100
Subject: [PATCH 1/3] ARM: ixp4xx: use normal prototype for {read, write}s{b,
 w, l}
In-Reply-To: <1454689262-613421-1-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Fri, 5 Feb 2016 17:20:48 +0100")
References: <1454689262-613421-1-git-send-email-arnd@arndb.de>
Message-ID: <m3mvr2bgh9.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> ixp4xx defines the arguments to its __indirect_writesb() and other
> functions as pointers to fixed-size data. This is not necessarily
> wrong, and it works most of the time, but it causes warnings in
> at least one driver:
>
> drivers/net/ethernet/smsc/smc91x.c: In function 'smc_rcv':
> drivers/net/ethernet/smsc/smc91x.c:495:21: error: passing argument 2 of '__indirect_readsw' from incompatible pointer type [-Werror=incompatible-pointer-types]
>    SMC_PULL_DATA(lp, data, packet_len - 4);
>
> All other definitions of the same functions pass void pointers,
> so doing the same here avoids the warnings.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ixp4xx/include/mach/io.h | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)

Acked-by: Krzysztof Ha?asa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
