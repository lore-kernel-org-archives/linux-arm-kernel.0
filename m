From: tibor@harsszegi.com (tibor at harsszegi.com)
Date: Wed, 10 Jul 2013 02:53:44 +0200
Subject: NSA310 + DT
In-Reply-To: <20130709202143.GD26223@lunn.ch>
References: <51DC564A.8050002@harsszegi.com>
 <20130709193605.GC26223@lunn.ch> <20130709202143.GD26223@lunn.ch>
Message-ID: <2544f179ed4349545a25aa60d52a664a@harsszegi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello guys,

> Hi Tibor
> 
> Which NSA310 do you actually have? Apparently there are actually two
> variants:
> 
> http://zyxel.nas-central.org/wiki/Category:NSA-310
> 
> It could be yours is actually the rebranded TDC Homedisk. If so, we
> should add a new .dts file for it.
> 
> Andrew

Well that's a good one. Hohestly have zero idea :(
Here is lspci and cpuinfo.

root at nsa310:~# lspci
00:00.0 Host bridge: Marvell Technology Group Ltd. 88F6281 [Kirkwood] 
ARM SoC (rev 03)
00:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 03)
root at nsa310:~# cat /proc/cpuinfo
processor       : 0
model name      : Feroceon 88FR131 rev 1 (v5l)
BogoMIPS        : 1196.85
Features        : swp half thumb fastmult edsp
CPU implementer : 0x56
CPU architecture: 5TE
CPU variant     : 0x2
CPU part        : 0x131
CPU revision    : 1

Hardware        : Marvell Kirkwood (Flattened Device Tree)
Revision        : 0000
Serial          : 0000000000000000

I was using the patches from here, they worked
flawlessly (until pre DT kernels)

https://github.com/peeter123/NSA310-320-debian

Cheers,
Tibor
