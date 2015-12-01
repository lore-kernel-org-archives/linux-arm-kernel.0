From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 23:46:03 +0100
Subject: [PATCH] ARM: ixp4xx: fix read{b,w,l} return types
In-Reply-To: <m3h9kaz2ej.fsf@t19.piap.pl>
References: <4577677.sEiIMqkHSM@wuerfel> <m3h9kaz2ej.fsf@t19.piap.pl>
Message-ID: <4900418.HEVAcnQtkC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 13:31:16 Krzysztof Ha?asa wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On ixp4xx, the readl() function returns an 'unsigned long' output
> > when indirect I/O is used. This is unlike any other platform, and
> > it causes lots of harmless compiler warnings, such as:
> >
> > drivers/ata/libahci.c: In function 'ahci_show_host_version':
> > drivers/ata/libahci.c:254:22: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
> > drivers/block/mtip32xx/mtip32xx.c: In function 'mtip_hw_read_registers':
> > drivers/block/mtip32xx/mtip32xx.c:2602:31: warning: format '%X' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
> > drivers/block/cciss.c: In function 'print_cfg_table':
> > drivers/block/cciss.c:3845:25: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
> >
> > This changes all six of the ixp4xx specific I/O read functions
> > to return the same types that we have in the normal asm/io.h,
> > to avoid the warnings.
> 
> Thanks for fixing this.
> 
> Acked-by: Krzysztof Halasa <khalasa@piap.pl>
> 

Applied to fixes for 4.4 now with your ack.
