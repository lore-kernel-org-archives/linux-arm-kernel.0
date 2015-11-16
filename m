From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 16 Nov 2015 09:06:07 +0530
Subject: [PATCH] dmaengine: edma: fix build without CONFIG_OF
In-Reply-To: <17811472.bY8CqmdEVy@wuerfel>
References: <17811472.bY8CqmdEVy@wuerfel>
Message-ID: <20151116033607.GV25173@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 03:00:57PM +0100, Arnd Bergmann wrote:
> During the edma rework, a build error was introduced for the
> case that CONFIG_OF is disabled:
> 
> drivers/built-in.o: In function `edma_tc_set_pm_state':
> :(.text+0x43bf0): undefined reference to `of_find_device_by_node'
> 
> As the edma_tc_set_pm_state() function does nothing in case
> we are running without OF, this adds an IS_ENABLED() check
> that turns the function into an empty stub then and avoids the
> link error.

Applied, thanks

-- 
~Vinod
