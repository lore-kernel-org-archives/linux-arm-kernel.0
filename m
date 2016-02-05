From: fijam@archlinux.us (JM)
Date: Fri, 5 Feb 2016 06:01:18 +0100
Subject: marvell_cesa fails to register on kirkwood (88F6282)
Message-ID: <CAKzmTe0mvZD5UwqM47uXbM7Z7oAJpE4g4BVMba1hkzqNu+Zbgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am testing marvell_cesa on a kirkwood device (QNAP TS-212p, Marvell
Kirkwood 88F6282, dts: http://pastebin.com/Gk95KFHf ).
As of kernel 4.4 (4.4.0-trunk-kirkwood #1 Debian 4.4-1~exp1) it fails
in the following way:

modprobe marvell_cesa allhwsupport=1
dmesg | tail -n 1
[ 1057.855091] marvell-cesa: probe of f1030000.crypto failed with error -12

or:

modprobe marvell_cesa
dmesg | tail -n 1
[ 9178.399357] marvell-cesa: probe of f1030000.crypto failed with error -524

With kernel 4.3 it would fail with error -22 on that hardware. There
are scattered reports from other users experiencing the same issue
(1,2,3)

I wonder if this is a result of an invalid definition of the
crypto-sram in the dts of this SoC, or perhaps some other problem
(PEBKAC included).

I can provide SSH access to the affected device if needed.

Best regards,
Jan

[1] http://archlinuxarm.org/forum/viewtopic.php?f=53&t=9249&start=30#p49373
[2] http://www.dd-wrt.com/phpBB2/viewtopic.php?p=1003189&sid=43aea81e160fffefe21c7bd64e2de958
[3] http://forum.doozan.com/read.php?2,12096,24409#msg-24409
