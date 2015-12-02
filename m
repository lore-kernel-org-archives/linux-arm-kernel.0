From: tony@atomide.com (Tony Lindgren)
Date: Wed, 2 Dec 2015 07:00:05 -0800
Subject: [RFC v02 03/15] dmaengine: core: Introduce new, universal API to
 request a channel
In-Reply-To: <565EC14A.6020502@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
 <20151130155142.GZ2517@atomide.com> <565D56A0.2090204@ti.com>
 <20151201170031.GT23396@atomide.com> <565EC14A.6020502@ti.com>
Message-ID: <20151202150005.GB23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151202 02:01]:
> On 12/01/2015 07:00 PM, Tony Lindgren wrote:
> >> I see. The dm81xx basically am33xx/am43xx?
> > 
> > Yeah similar to am33xx with different clocks and with a bunch of accelerators.
> > 
> >> Actually I would prefer to use the dmaengine's event router framework and we
> >> do have support for the am33xx/am43xx type of crossbar already implemented.
> >> I'm going to resend the DTS series for am33xx/am43xx to convert them to use
> >> the new DT bindings along with the dma event router support:
> >> https://www.mail-archive.com/linux-omap%40vger.kernel.org/msg120828.html
> > 
> > OK yes a dmaengine event router works too when available. Good to see
> > them as separate driver instances now :) Are only the dts changes missing
> > now?
> > 
> > FYI, when we have separate interconnect driver instances, we don't want to
> > and cannot tweak registers outside the interconnect instance because of them
> > being in separate clock and/or power domains :p
> 
> What does this mean in practice? We can not touch these registers? The DMA
> crossbar is a separate driver from the eDMA driver.

Seem like it should not affect DMA crossbar as it's a separate driver.

What I meant is we need a separate driver for clocks, pinctrl, regulators,
PHY, crossbar or syscon to use the SCM registers from drivers sitting on a
L4 interonnect.

> > In any case, it seems there's no harm using pinctrl for evtmux on dm81xx
> > until the event router is available. It's currently only needed on the
> > t410 emmc that I'm aware of :)
> 
> The AM33xx/AM43xx DMA crossbar support is in 4.4 already:
> 42dbdcc6bf96 dmaengine: ti-dma-crossbar: Add support for crossbar on AM33xx/AM43xx

OK great.

Tony
