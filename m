From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 7 Sep 2016 18:18:25 -0700
Subject: [PATCH v2 2/2] MMC: meson: initial support for GXBB platforms
In-Reply-To: <7hy433qpoo.fsf@baylibre.com>
References: <20160803231843.23012-1-khilman@baylibre.com>
 <20160803231843.23012-2-khilman@baylibre.com>
 <20160823012124.GQ6502@codeaurora.org>
 <7hy433qpoo.fsf@baylibre.com>
Message-ID: <20160908011825.GA19921@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07, Kevin Hilman wrote:
> Stephen Boyd <sboyd@codeaurora.org> writes:
> > On 08/03, Kevin Hilman wrote:
> >> +	host->mux.hw.init = &init;
> >> +
> >> +	host->mux_clk = devm_clk_register(host->dev, &host->mux.hw);
> >
> > Hmm I was hoping to get rid of devm_clk_register() and replace it
> > with devm_clk_hw_register() instead. All part of my grand plan to
> > split providers from consumers, but this driver is different in
> > the sense that it registers clks to provide to itself. Maybe we
> > should make __clk_create_clk() into a real clk provider API so
> > that we can use devm_clk_hw_register() here and then generate a
> > clk for this device from the hw structure.
> 
> So is there something else I should do here, or can we rework this later
> after you rework the framework a bit?
> 

That can wait for later. If nobody takes care of it I'll do it
when I get around to it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
