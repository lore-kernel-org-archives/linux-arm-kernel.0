From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 13 Jun 2012 15:10:29 -0400
Subject: Converting kirkwood-goflexnet to DTS
In-Reply-To: <CAMW5Ufar3+RFwwmPd5xS_aNBKz6VLyDnw_3_aJDOR-xRz1kkTw@mail.gmail.com>
References: <CAMW5Ufar3+RFwwmPd5xS_aNBKz6VLyDnw_3_aJDOR-xRz1kkTw@mail.gmail.com>
Message-ID: <20120613191029.GI14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 02:27:25PM -0400, Josh Coombs wrote:
> I have a functional Seagate GoFlex Net running 3.4.2 using a patched
> in mach-kirkwood board definition from the Archlinux ARM port.  Based
> on my reading it appears the way to move forward is to build a DTS
> file for the device and once stable, it might be possible to get it
> supported directly by the mainline kernel for a change.

Yep.

> It looks like Kirkwoods are currently getting some DTS attention, I'm
> slowly trying to bootstrap myself on the format.  I have a working
> board file and a working appliance to test on.  Are there any pointers
> or docs I can review to try and make an initial try at lighting this
> device via a DTS based kernel?

I would recommend looking at how we did the first board, the dreamplug.
Files of interest are:

arch/arm/boot/dts/kirkwood.dtsi
arch/arm/boot/dts/kirkwood-dreamplug.dts
arch/arm/mach-kirkwood/board-dt.c
arch/arm/mach-kirkwood/board-dreamplug.c
arch/arm/mach-kirkwood/Kconfig
arch/arm/mach-kirkwood/Makefile
arch/arm/mach-kirkwood/Makefile.boot

commit 3d468b6 seems to be a good place to start.

For your first patch series, use the dtb to tell the kernel what board
it is on.  Once that's working, then you just start coverting over
drivers one by one.  Several are already done.

hth,

Jason.
