From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Feb 2014 23:12:51 +0100
Subject: Stuck getting DTS working for a new kirkwood board
In-Reply-To: <5307CCCD.5010505@sigpipe.me>
References: <5306721B.7020403@sigpipe.me>
 <20140221013407.GX7862@titan.lakedaemon.net>
 <5307029C.20006@sigpipe.me>
 <20140221151530.GZ7862@titan.lakedaemon.net>
 <5307A727.9080508@sigpipe.me>
 <20140221200855.GM7862@titan.lakedaemon.net>
 <5307CCCD.5010505@sigpipe.me>
Message-ID: <20140221221251.GH11878@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dashie

A few more tips for you

> Kernel command line: mtdparts=orion_nand:0x000e0000 at 0x00000000(u-boot)ro,0x1d73c0 at 0x000e0000(uImage),0x86cb58 at 0x2b73c0(uInitrd),- at 0xb23f18(rootfs) console=ttyS0,115200n8 verbose mem=256M root=/dev/sda2 rootdelay=8 ip=off earlyprintk

You seem to be missing nand in your DT. You should be able to work out
the partition sizes from the information above.

> rtc-mv f1010300.rtc: internal RTC not ticking

This suggests there is a different RTC on the board than the built in
one. It is probably on i2c. You can probably get the address using the
i2cdetect program. If you have boot logs from the vendor kernel it
will probably tell you what device it is.

     Andrew
