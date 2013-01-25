From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 20:03:44 +0000
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <20130125183407.GC7393@obsidianresearch.com>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <CABJ1b_QaTBLgGASTs2yi435jR=LepN-iY97xTLXAu1hZw69Wuw@mail.gmail.com>
 <20130125183407.GC7393@obsidianresearch.com>
Message-ID: <201301252003.45295.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 January 2013, Jason Gunthorpe wrote:
>         // MBUS Decoder window for NAND
>         nand at f4000000 {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 compatible = "simple-bus", "marvell,orion-mbus";
>                 mbus-target = 0xXXXXX;
>                 ranges = <0 0xf4000000 0x10000>;
> 
>                 nand at 0 {
>                         cle = <0>;
>                         ale = <1>;
>                         bank-width = <1>;
>                         chip-delay = <50>;
>                         compatible = "marvell,orion-nand";
>                         reg = <0x0 0x400>;
>                 };
>         };
> 

Yes, this looks quite reasonable. I would not claim compatibility with
"simple-bus" though because it clearly isn't simple.

If we need a driver to set up the mappings, that driver should
also instantiate its child devices.

	Arnd
