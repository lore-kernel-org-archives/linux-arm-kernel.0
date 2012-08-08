From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Aug 2012 10:59:29 +0100
Subject: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
In-Reply-To: <201208080828.35451.arnd@arndb.de>
References: <20120807170333.GV16861@opensource.wolfsonmicro.com>
 <20120808080411.GB4728@gmail.com>
 <201208080828.35451.arnd@arndb.de>
Message-ID: <20120808095928.GI16861@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 08:28:35AM +0000, Arnd Bergmann wrote:

> In general, it seems easier to use the same domain type for both cases.
> I don't think that MOP500_AB8500_VIR_GPIO_IRQ_BASE is used anywhere
> else besides the .irq_base definition in board-mop500.c, so I would guess
> that you can just remove that identifier and always use the linear
> domain.

Given how easy this is to get working it doesn't seem sensible to avoid
it - there's a clear pattern already for maintaining support for legacy
domains.
