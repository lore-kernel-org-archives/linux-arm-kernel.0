From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 2 Sep 2014 05:05:46 +0200
Subject: [PATCH 15/15] tty: serial: 8250: omap: add dma support
In-Reply-To: <5404B149.6010400@linutronix.de>
References: <20140821184416.GF10066@atomide.com>
 <53FE3779.5090908@linutronix.de>
 <20140827202313.GF16006@atomide.com>
 <20140828082348.GA5413@linutronix.de>
 <20140828164645.GG16006@atomide.com>
 <53FF84DF.7080406@linutronix.de>
 <20140828225454.GM16006@atomide.com>
 <540048B4.7010807@linutronix.de>
 <20140829161221.GO16006@atomide.com>
 <5404B149.6010400@linutronix.de>
Message-ID: <20140902030546.GB6724@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 01, 2014 at 07:47:53PM +0200, Sebastian Andrzej Siewior wrote:
> On 08/29/2014 06:12 PM, Tony Lindgren wrote:
> > Looks like the paste bug is there for sure, doing off idle and pasting
> > 240 characters to the console can hang the UART RX after few attempts,
> > and pasting 16 charactes won't show up at all if the system is idling.
> > So you may want to play with that too a bit :)
> 
> One character wakes it up. After that you can send 16, 64 and you see
> them. Right away. No delay.
> 
> If you send "a lot" data in one-go it takes approx 152 characters until
> the first one is displayed properly at 115200,8N1. That is approx 13ms.
> Could it take that long to get up and be ready?

I noticed the same behaviour when I tested the runtime PM stuff on
my N900 with the existing serial-omap driver and I also assumed,
that the chip needs that long to get up.

> Comparing it with serial-omap I see the same thing: I takes approx the
> same amount of data until the first one is displayed. After a lot of
> "long" writes which wake the chip up from idle I manage to freeze both,
> the serial-omap driver and mine driver.
> 
> One thing that is probably a dumb idea is that printk in
> omap_8250_mdr1_errataset().
> Would it be possible that when I hit a printk in the resume path that I
> may deadlock and box will freeze?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140902/60396c65/attachment.sig>
