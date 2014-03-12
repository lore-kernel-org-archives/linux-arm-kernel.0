From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 12 Mar 2014 20:44:54 +0800
Subject: [PATCH 2/2] ARM: dts: berlin2q: add the Marvell BG2-Q DMP
 device tree
In-Reply-To: <20140312123759.GB15090@lunn.ch>
References: <1394622364-6848-1-git-send-email-antoine.tenart@free-electrons.com>
 <1394622364-6848-3-git-send-email-antoine.tenart@free-electrons.com>
 <20140312200428.23178d69@xhacker> <20140312123759.GB15090@lunn.ch>
Message-ID: <20140312204454.36a6be85@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Wed, 12 Mar 2014 05:37:59 -0700
Andrew Lunn <andrew@lunn.ch> wrote:

> > > +/dts-v1/;
> > > +#include "berlin2q.dtsi"
> > > +
> > > +/ {
> > > +	model = "Marvell BG2-Q DMP";
> > > +	compatible = "marvell,berlin2q-dmp", "marvell,berlin2q",
> > > "marvell,berlin"; +
> > > +	memory {
> > > +		device_type = "memory";
> > > +		reg = <0x00000000 0x40000000>;
> > 
> > The memory size of BG2Q DMP is 2GB.
> 
> Jisheng
> 
> Does this imply that the RAM is inside the SoC package, and that
> there is no external memory interface which can be used to add more
> RAM?

Nope. The ram is on the board. After talking with Alex, I think it's 
reasonable to put the memory node in dts as the original patch does.

However, we need to set the correct memory size of BG2Q DMP board.

Thanks,
Jisheng
