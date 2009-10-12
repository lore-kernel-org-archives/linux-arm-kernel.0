From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Sun, 11 Oct 2009 21:53:45 -0500
Subject: [PATCH v1 1/2] arm: a driver for on-chip ETM and ETB
In-Reply-To: <20091011222938.GA13244@n2100.arm.linux.org.uk>
References: <1255279286-8904-1-git-send-email-virtuoso@slind.org>
	<63386a3d0910111507r681e69c4ka843cac9ad0e8b40@mail.gmail.com>
	<20091011222938.GA13244@n2100.arm.linux.org.uk>
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B1C0F5F@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Sunday, October 11, 2009 5:30 PM

> > > +       clk = clk_get(&pdev->dev, "emu_core_alwon_ck");
> > > +       clk_enable(clk);
> > > +
> > > +       clk = clk_get(&pdev->dev, "emu_per_alwon_ck");
> > > +       clk_enable(clk);
> > > +
> > > +       clk = clk_get(&pdev->dev, "emu_mpu_alwon_ck");
> > > +       clk_enable(clk);
> > > +
> > > +       clk = clk_get(&pdev->dev, "emu_src_ck");
> > > +       clk_enable(clk);
> >
> > Are these clocks really generic? It looks a lot like OMAP-specific
> > stuff. Is it possible to hide these behind a single clock inside the
> > platform? like "etbclock" or so that increase refcount of the others
> > by 1?

More than ETM/ETB could be using those omap generated clocks.  Any one of the above can also source the trace clocks.
