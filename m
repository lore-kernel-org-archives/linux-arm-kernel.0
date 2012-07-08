From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 8 Jul 2012 18:57:22 +0000
Subject: [PATCH 3/3] ARM: dts: dove: Integrate devicetree support
In-Reply-To: <4FF8A541.6020508@googlemail.com>
References: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
 <4FF88F31.7050402@gmail.com> <4FF8A541.6020508@googlemail.com>
Message-ID: <201207081857.22601.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 07 July 2012, Sebastian Hesselbarth wrote:
> I should have mentioned that this patch series' main goal was not
> to present a full blown DT support for mach-dove but to keep up
> with ongoing DT support for mach-kirkwood by Andrew Lunn. Both
> machs heavily rely on plat-orion and these patches were meant to
> help porting to DT.
> 
> I can keep the patches for now and resend them later when more
> core stuff of plat-orion has been ported to DT.

A lot of the devices you have in your new board files actually
have DT bindings already or have patches that got posted.

I think it makes more sense for mach-dove to go all the way
from the start:

* Add full .dts files for the two boards that are already supported
in mainline, and for the board you are testing with

* Add your board-dt.c contents directly to common.c

* Have no other board-* files at all, but instead work on adding
the missing bindings.

I don't think there is much value in duplicating the two exisitng
board files like your patch does. Adding support for a new mach-dove
board should be doable without such a file in 3.6.

	Arnd
