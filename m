From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 27 Aug 2014 18:15:15 +0300
Subject: [PATCH] clk: ti: change clock init to use generic of_clk_init
In-Reply-To: <1408628959-32442-1-git-send-email-t-kristo@ti.com>
References: <1408628959-32442-1-git-send-email-t-kristo@ti.com>
Message-ID: <53FDF603.6040003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2014 04:49 PM, Tero Kristo wrote:
> Previously, the TI clock driver initialized all the clocks hierarchically
> under each separate clock provider node. Now, each clock that requires
> IO access will instead check their parent node to find out which IO range
> to use.
>
> This patch allows the TI clock driver to use a few new features provided
> by the generic of_clk_init, and also allows registration of clock nodes
> outside the clock hierarchy (for example, any external clocks.)
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Stefan Assmann <sassmann@kpanic.de>

Tested-by: Jyri Sarha <jsarha@ti.com>
