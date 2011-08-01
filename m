From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Aug 2011 09:27:48 +0100
Subject: [PATCH v2 4/7] tty: serial: support device tree in pxa
In-Reply-To: <CAN1soZwYjQp5c=4f=CbqjrXFxzSURSv6i9QHMyjyPszs=kzh9w@mail.gmail.com>
References: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-3-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-4-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-5-git-send-email-haojian.zhuang@marvell.com>
	<20110729164539.GM11164@ponder.secretlab.ca>
	<20110729164922.GA30298@n2100.arm.linux.org.uk>
	<CAN1soZwYjQp5c=4f=CbqjrXFxzSURSv6i9QHMyjyPszs=kzh9w@mail.gmail.com>
Message-ID: <20110801082748.GB15578@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2011 at 10:50:47AM +0800, Haojian Zhuang wrote:
> On Sat, Jul 30, 2011 at 12:49 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Oh ffs, why is this DT stuff causing all the clk stuff to have to change.
> > And specifically why is stuff converting to use clk_get_sys().
> >
> > clk_get_sys() is there to allow system devices to get their clocks.
> > It's not for general drivers to use.
> >
> > Please, stop this madness.
> >
> 
> So how could I get these clocks?

Add the new _stable_ DT device name to the clkdev list.
