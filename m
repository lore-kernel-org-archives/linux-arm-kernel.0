From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 01 Oct 2018 13:46:13 +0200
Subject: [PATCH 2/2] ARM: ixp4xx: include linux/mtd/platnand.h
In-Reply-To: <20180926130458.2406549-2-arnd@arndb.de> (Arnd Bergmann's message
 of "Wed, 26 Sep 2018 15:04:39 +0200")
References: <20180926130458.2406549-1-arnd@arndb.de>
 <20180926130458.2406549-2-arnd@arndb.de>
Message-ID: <m3in2ldh4q.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The platform_nand_data structure definition is required for ixdp425
> but has now moved to a new header file:
>
> arch/arm/mach-ixp4xx/ixdp425-setup.c:98:15: error: variable 'ixdp425_flash_nand_data' has initializer but incomplete type
>  static struct platform_nand_data ixdp425_flash_nand_data = {
>                ^~~~~~~~~~~~~~~~~~
> arch/arm/mach-ixp4xx/ixdp425-setup.c:99:3: error: 'struct platform_nand_data' has no member named 'chip'
>
> Fixes: 19cf5dfa3a31 ("mtd: rawnand: Move platform_nand_xxx definitions out of rawnand.h")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ixp4xx/ixdp425-setup.c | 1 +

Right.
Acked-by: Krzysztof Halasa <khalasa@piap.pl>

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
