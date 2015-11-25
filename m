From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 25 Nov 2015 13:31:16 +0100
Subject: [PATCH] ARM: ixp4xx: fix read{b,w,l} return types
In-Reply-To: <4577677.sEiIMqkHSM@wuerfel> (Arnd Bergmann's message of "Fri, 20
 Nov 2015 23:20:28 +0100")
References: <4577677.sEiIMqkHSM@wuerfel>
Message-ID: <m3h9kaz2ej.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On ixp4xx, the readl() function returns an 'unsigned long' output
> when indirect I/O is used. This is unlike any other platform, and
> it causes lots of harmless compiler warnings, such as:
>
> drivers/ata/libahci.c: In function 'ahci_show_host_version':
> drivers/ata/libahci.c:254:22: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
> drivers/block/mtip32xx/mtip32xx.c: In function 'mtip_hw_read_registers':
> drivers/block/mtip32xx/mtip32xx.c:2602:31: warning: format '%X' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
> drivers/block/cciss.c: In function 'print_cfg_table':
> drivers/block/cciss.c:3845:25: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
>
> This changes all six of the ixp4xx specific I/O read functions
> to return the same types that we have in the normal asm/io.h,
> to avoid the warnings.

Thanks for fixing this.

Acked-by: Krzysztof Halasa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
