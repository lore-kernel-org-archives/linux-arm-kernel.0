From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Thu, 29 Oct 2009 09:35:10 +0100
Subject: marvell kirkwood / openrd-base kernel freeze on bootup with
	PICe->PCI bridge
In-Reply-To: <200910290936.40397.dk-arm-linux@gmx.de>
References: <200910290936.40397.dk-arm-linux@gmx.de>
Message-ID: <20091029093510.4e9a8dde@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Oct 2009 10:36:40 +0200
Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:

> Uncompressing Linux............................................................................................................................................................ done.
> 
> The PCIe->PCI bridge is a Marvell 88SB2211 evaluation board and I expect it works well - at least it does in all other environments I've tested so far.

> Please can someone help me to track this down?
> Some tips how to debug such a problem using openocd are very welcome, too!
> I'm completely lost in space :(

Try attaching gdb to it, i.e.,

	arm-unknown-linux-gnu-gdb vmlinux

and then connecting to openocd's GDB remote with

	target remote localhost:3333

After that you can backtrace and examine stuff as you normally do with
GDB. Remeber to start with nohlt when you use GDB, but I guess you're
already doing that.

// Simon
