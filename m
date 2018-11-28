From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 28 Nov 2018 13:29:04 -0800
Subject: [PATCH 09/15] clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC
 output
In-Reply-To: <20181128093013.24442-11-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-11-wens@csie.org>
Message-ID: <154344054442.88331.8887745218976145062@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chen-Yu Tsai (2018-11-28 01:30:07)
> On the R40, in addition to a mux between the RTC's own RC oscillator and
> an external 32768 Hz crystal, which are muxed inside the RTC module, the
> CCU also has its own RC oscillator, which runs at around 2 MHz, and can
> be muxed with the LOSC output from the RTC. This muxed output is called
> "SYS 32K" in the module clock diagram, but otherwise referred to as the
> LOSC throughout the CCU documentation.
> 
> The RC oscillator is not very accurate, even though it has an undocumented
> calibration function. We really want a precise clock at 32768 Hz,
> instead of something at around 32 KHz. This patch forces the SYS 32K
> clock to use the RTC output as its parent, and doesn't bother
> registering the internal oscillator nor a clock mux.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
