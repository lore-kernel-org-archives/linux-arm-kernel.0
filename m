From: olof@lixom.net (Olof Johansson)
Date: Mon, 10 Nov 2014 13:34:19 -0800
Subject: serial: of-serial: fetch line number from DT
Message-ID: <CAOesGMjzs=dThDv6S8Xvo+ym-XECaQhTQ8NV6t46fQZ1LoJnHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

This commit:

commit 1bd8324535ec1ff44aef55c0e40b9e7d56b310fb
Author: Lucas Stach <dev@lynxeye.de>
Date:   Mon Nov 3 23:16:54 2014 +0100

    serial: of-serial: fetch line number from DT

    The general agreed way to specify a fixed line number
    for a serial console is to provide a "serial" alias
    in the devicetree. Start parsing this property in
    of_serial.

    Signed-off-by: Lucas Stach <dev@lynxeye.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Broke a whole lot of tegra boards in last night's -next here. In
particular, I've been looking at tegra20-seaboard, which now doesn't
boot with console any more.

http://arm-soc.lixom.net/bootlogs/next/next-20141110/

Unfortunately, tegra has for a long time been specifying the aliases
as a fixed 1:1 mapping, but most environments rely on ttyS0 being the
first _activated_ serial port. That's obviously going to break things
here. :(

Greg, can you please revert until we get the tegra-side fixes in for
this, or we're in for a pretty lousy time w.r.t. bisecting problems
across the two mergepoints?

Stephen: I suppose the best way to handle this on tegra is to specify
the aliases per-board instead of in the soc dtsi today.

Apologies for not replying to the patch directly -- it was only ever
posted to linux-serial and I don't seem to be subscribed.


-Olof
