From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jan 2017 14:22:06 +0530
Subject: [PATCH v4 1/4] ARM: da850: fix infinite loop in clk_set_rate()
In-Reply-To: <1481124138-27337-2-git-send-email-bgolaszewski@baylibre.com>
References: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
 <1481124138-27337-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <b04c878f-97cf-f0a1-4968-154d96eda8d4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 December 2016 08:52 PM, Bartosz Golaszewski wrote:
> The aemif clock is added twice to the lookup table in da850.c. This
> breaks the children list of pll0_sysclk3 as we're using the same list
> links in struct clk. When calling clk_set_rate(), we get stuck in
> propagate_rate().
> 
> Create a separate clock for nand, inheriting the rate of the aemif
> clock and retrieve it in the davinci_nand module.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to fixes branch. The prefix for mach-davinci patches is "ARM:
davinci: ...". I fixed it up when applying. Please take care for future.

Thanks,
Sekhar
