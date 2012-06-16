From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Jun 2012 06:56:49 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FDB5ECF.3000701@firmworks.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206151127.24386.arnd@arndb.de> <4FDB5ECF.3000701@firmworks.com>
Message-ID: <201206160656.50125.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 June 2012, Mitch Bradley wrote:
> >               #address-cells =<1>;
> >               #size-cells =<1>;
> >               ranges;
> 
> In light of the reg entries below, perhaps #size-cells=0 ?
> >
> >
> >               dmae at 0xfe008020{
> >                       compatible = "renesas,sh-dma";
> >                       reg =<0xfe008020 0xfe00828f
> >                               0xfe009000 0xfe00900b>
> >                       interrupts =<0x20c0 0x2000 0x2020 0x2040 0x2060 0x2080 0x20a0>;
> >               };
> >

These are actually ranges I copied from the static resource definitions,
I just forgot to change the format from start-end to start-length.
It should really be

			reg =<0xfe008020 0x270 0xfe009000 0xc>;

Sorry about that.

	Arnd
