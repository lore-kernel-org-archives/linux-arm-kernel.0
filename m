From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 11:10:22 +0100
Subject: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
In-Reply-To: <BANLkTikq2mu=rNiRuRPjikkpXuH6DKOsFA@mail.gmail.com>
References: <1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
	<20110417164830.GE17935@S2100-06.ap.freescale.net>
	<BANLkTimwvX633UaUoc4P4DD1xnpLbMTrZA@mail.gmail.com>
	<20110420140120.GF1965@S2100-06.ap.freescale.net>
	<BANLkTimzk89VC1Vti4CZ60TTJ20e2YpwNg@mail.gmail.com>
	<20110421062924.GB4024@S2100-06.ap.freescale.net>
	<BANLkTimq8_R-CJmryTvRWHZ+-2vqj-Y6cQ@mail.gmail.com>
	<20110421091115.GH4024@S2100-06.ap.freescale.net>
	<BANLkTim_5fsJ06CTgxAvPjrb8y5FpW=xRg@mail.gmail.com>
	<BANLkTikq2mu=rNiRuRPjikkpXuH6DKOsFA@mail.gmail.com>
Message-ID: <20110428101022.GA17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 09:52:17AM +0200, Per Forlin wrote:
> I wanted to test the performance without cache penalty but removing
> dma_map_sg may not work since it produces the physical mapped sg list.
> This is not as simple as I first thought. Make a copy for dma_map_sg
> (call it dma_map_sg_no_cache) and modify it to not clean/inc the
> cache. Replace dma_map_sg with dma_map_sg_no_cache in the mxs-mmc
> driver.
> Removing dma_unmap should be ok for this test case.
> Do you still get very low numbers?

We can live in the hope that this is gathering evidence to illustrate
why having DMA incoherent caches are bad news for performance, and that
one day ARM Ltd will one day give us proper DMA cache coherency for all
devices.
