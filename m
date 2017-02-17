From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 17 Feb 2017 16:42:19 +0100
Subject: [PATCH 0/8] ARM: sun8i: a33: Mali improvements
In-Reply-To: <2cecfc48-576f-3888-08aa-1fe2edc3c752@math.uni-bielefeld.de>
References: <10fd28cb-269a-ec38-ecfb-b7c86be3e716@math.uni-bielefeld.de>
 <20170216184524.cxcy2ux37yrwutla@lukather>
 <2cecfc48-576f-3888-08aa-1fe2edc3c752@math.uni-bielefeld.de>
Message-ID: <20170217154219.d4z2gylzcrzntlt3@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/2017 at 13:45:44 +0100, Tobias Jakobi wrote:
> > The device tree is a representation of the hardware itself. The state
> > of the driver support doesn't change the hardware you're running on,
> > just like your BIOS/UEFI on x86 won't change the device it reports to
> > Linux based on whether it has a driver for it.
> Like Emil already said, the new bindings and the DT entries are solely
> introduced to support a proprietary out-of-tree module.
> 

Because device tree describes the hardware, the added binding doesn't
support any particular module. The eventually upstreamed drvier will
share the same bindings.

> The current workflow when introducing new DT entries is the following:
> - upstream a driver that uses the entries
> - THEN add the new entries
> 

Exactly not, if you do that, checkpatch will complain loudly. Because
you must not add a driver using bindings that are not documented first.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
