From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 25 Jun 2010 08:01:45 +0200
Subject: clock updates
In-Reply-To: <20100623232422.GB16584@trinity.fluff.org>
References: <20100623232422.GB16584@trinity.fluff.org>
Message-ID: <000801cb142b$e6624420$b326cc60$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, June 24, 2010 1:24 AM Ben Dooks wrote:

> I've been looking into updating the current samsung socs to use
> clkdev to lookup clocks. Currently we have a few issues that we
> could do with sorting before running the conversion to clkdev.
> 
> Firstly, the s5pc100 has some clocks that could be merged into
> common s5p, and a few which don't seem to match the others in
> the s5p series.
> 
> The i2s clocks which we should look at mergining are:
> 
> i2s_cdclk<0..2>
> pcm_cdclk<0..l>
> 
> also, clocks that have may need changing:
> 
> rotator	     => rot
> keyif	     => keypad
> 
> this isn't an complete list, still working on the changes.
> 
> The big changes with respect to drivers is that we will now be using
> clk_get(dev, NULL) to get the clock names, and any bus clocks such
> as the sdhci bus clock will be updated.
> 
> The intention with both the SDHCI and the SPI is to change the clock
> lookups to reflect the mux positions, so the sdhci clocks on the
> s3c64xx would be changed to use the following lookups:
> 
> hsmmc	=> mux0
> mmc_bus	=> mux2
> 48m	=> mux3

I like this idea, but I wonder how the drivers will be able to get/control
the additional peripheral clocks (like sclk_fimc and sclk_cam for fimc for
example)?

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
