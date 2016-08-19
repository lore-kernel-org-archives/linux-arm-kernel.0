From: radioconfusion@gmail.com (radioconfusion at gmail.com)
Date: Fri, 19 Aug 2016 14:54:50 +0300
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
Message-ID: <57b6f38c.23012e0a.374a0.56c6@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> On Tue, 05 Jul 2016 11:46:30 +0300, radioconfusion at gmail.com wrote:

> My Armada 385 -device hangs when using marvell-cesa -driver.
> I'm using Linux 4.4.10 and armada-385-db-ap.dts.
> I have also tried with the driver version of Linux 4.7-rc3.
> 
> Please see https://bugzilla.kernel.org/show_bug.cgi?id=120111 for details.

I just tested the marvell-cesa with Linux 4.8-rc2 and Armada 385.
There is still the same hanging issue (originally described on
https://bugzilla.kernel.org/show_bug.cgi?id=120111).

Please let me ask which model of Armada board has been verified to work with the
marvell-cesa driver? I'm using a custom board based on 88F6820. Is this SoC
model fully supported by the driver? Do you know if there is some necessary
hardware initializations which must be done on u-boot? I'm using latest Marvell
patch set (2015_T1.0p16) on u-boot.

My test case have been:
# cryptsetup benchmark --cipher aes-cbc

and that always freezes the board.

Best Regards
Jussi
