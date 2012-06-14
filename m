From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 14 Jun 2012 10:00:10 -0400
Subject: Converting kirkwood-goflexnet to DTS
In-Reply-To: <CAMW5UfYMxSKmGAvZ5ucNyr8AL0zBAj5jpt+s8YhogKaWdv2mAw@mail.gmail.com>
References: <CAMW5Ufar3+RFwwmPd5xS_aNBKz6VLyDnw_3_aJDOR-xRz1kkTw@mail.gmail.com>
 <20120613191029.GI14756@titan.lakedaemon.net>
 <CAMW5UfYMxSKmGAvZ5ucNyr8AL0zBAj5jpt+s8YhogKaWdv2mAw@mail.gmail.com>
Message-ID: <20120614140010.GK14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 09:28:24AM -0400, Josh Coombs wrote:
> On Wed, Jun 13, 2012 at 3:10 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > I would recommend looking at how we did the first board, the dreamplug.
> > Files of interest are:
> >
> > arch/arm/boot/dts/kirkwood.dtsi
> > arch/arm/boot/dts/kirkwood-dreamplug.dts
> > arch/arm/mach-kirkwood/board-dt.c
> > arch/arm/mach-kirkwood/board-dreamplug.c
> > arch/arm/mach-kirkwood/Kconfig
> > arch/arm/mach-kirkwood/Makefile
> > arch/arm/mach-kirkwood/Makefile.boot
> >
> > commit 3d468b6 seems to be a good place to start.
> >
> > For your first patch series, use the dtb to tell the kernel what board
> > it is on. ?Once that's working, then you just start coverting over
> > drivers one by one. ?Several are already done.
> 
> First pass didn't boot, no kernel messages.  I'm going to go through
> the ArchLinux ARM superpatch to see if there are any items not
> directly pegged to the GoFlex that might be involved next, as well as
> cutting my conf down to just what's needed for the GFN to cut down my
> build times.  While I'm doing that, what do I NEED to configure for
> proper DTS support?
> 
...
> # CONFIG_SERIAL_OF_PLATFORM is not set

You'll need to set this ^^ and add the serial block to your dts file.  I
have a patch in the works to enable this and some other things by
default in kirkwood_defconfig.  So, hopefully this won't be an issue for
too much longer.

Also, EARLY_PRINTK is helpful if the bootloader already configured the
serial port.

hth,

Jason.
