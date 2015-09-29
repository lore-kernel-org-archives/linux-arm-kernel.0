From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Sep 2015 19:55:14 +0200
Subject: [PATCH v4 1/2] ARM: dma-mapping: Don't use outer_flush_range
 when the L2C is coherent
In-Reply-To: <20150929174835.GO21513@n2100.arm.linux.org.uk>
References: <1443545458-14807-1-git-send-email-gregory.clement@free-electrons.com>
 <1443545458-14807-2-git-send-email-gregory.clement@free-electrons.com>
 <20150929171054.GN21513@n2100.arm.linux.org.uk>
 <20150929193031.72bbebe8@free-electrons.com>
 <20150929174835.GO21513@n2100.arm.linux.org.uk>
Message-ID: <20150929195514.277efd80@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 29 Sep 2015 18:48:35 +0100, Russell King - ARM Linux wrote:

> > It might very well be the case. If there's enough PCIe traffic and a
> > PL310 cache maintenance operation happening at the same time, the
> > system will lockup. I'm a bit surprised that just the initialization of
> > the PCIe card generates enough traffic to trigger the deadlock, but
> > maybe I'm underestimating the problem.
> 
> It isn't every boot - the board has booted around 240 kernels so far and
> maybe 5% of them have needed the reset button pressed because of this.
> It only happens when I have the SATA card connected.  I don't have any
> drives on the SATA card at the moment though.

Hum, ok. Then I'm not sure it's the same problem. I believe it's
unlikely that the few PCIe accesses used just to enumerate the PCIe
device and initialize it are enough to cause the deadlock. But I don't
have (and anyway wouldn't fully understand) all the details about this
issue, so I can't say for sure.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
