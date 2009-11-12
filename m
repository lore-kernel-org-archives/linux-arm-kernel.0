From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Thu, 12 Nov 2009 08:31:26 +0100
Subject: [PATCH] ARM: enable PCI bridges after assigning resources (was
	orion/kirkwood pcie issue still open with 2.6.32-rc6 (marvell stock
	2.6.22.18 works!))
In-Reply-To: <200911120823.46427.dk-arm-linux@gmx.de>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<20091111171916.GC22741@mail.wantstofly.org>
	<1257989709.3918.8.camel@kero>
	<200911120823.46427.dk-arm-linux@gmx.de>
Message-ID: <20091112083126.2440aabd@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Nov 2009 08:23:44 +0100
Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:

> > When kernel is doing PCI resource assignment on ARM, nothing ever
> > enables PCI bridges, preventing any device behind them from working. The
> > following patch fixes this.
> 
> You hit it :)
> With your patch my FPGA works behind the bridge together with the marvell git u-boot.
>
> To see things clear:
> Is it possible that the marvell stock u-boot enables all devices before it starts the kernel
> and that's the reason why it worked if I booted the kernel from stock u-boot and it didn't
> work with the git u-boot?

The upstream (I suppose this is what you mean with "git"!) U-boot
doesn't touch the PCIe configuration at all as far as I know, but
probably the old Marvell U-boot does, and I guess that's the difference
we're seeing here.

Anyway, if U-boot isn't using PCIe, it shouldn't touch it, so it's good
to get the fixes into the kernel.

// Simon
