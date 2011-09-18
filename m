From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 18 Sep 2011 00:21:44 -0600
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <20110916160939.GA2100@arm.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-6-git-send-email-robherring2@gmail.com>
	<CAJuYYwSFu2HC+u2NY41+yw9tEyy85RKa4Dpm3SL+jbwS_OOA0A@mail.gmail.com>
	<4E71CE5D.9030900@ti.com> <20110916160939.GA2100@arm.com>
Message-ID: <20110918062144.GF3523@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 05:09:39PM +0100, Dave Martin wrote:
> For now, we express the mapping by putting an interrupt-map in the
> core-tile DT, but this feels inelegant as well as wasteful -- expressing
> "+ 32" using a table which is about 1K in size and duplicates that
> information 43 times.
> 
> Using a dedicated irq domain or a fake interrupt controller node to
> encapsulate the motherboard interrupts feels like a cleaner approach,
> but for now I'm not clear on the best way to do it.

An irq nexus node would indeed be something to investigate for your
particular case.  Look for examples of interrupt-map.  It is most
often used for handling IRQ swizzling on PCI busses.

g.
