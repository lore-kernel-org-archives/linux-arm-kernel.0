From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 19 Oct 2016 13:52:12 +0100
Subject: [PATCH] dmaengine: st_fdma: fix uninitialized variable access
In-Reply-To: <20161019120927.3251235-1-arnd@arndb.de>
References: <20161019120927.3251235-1-arnd@arndb.de>
Message-ID: <20161019125212.GA32299@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, 19 Oct 2016, Arnd Bergmann wrote:

> The newly added st_fdma driver introduces a build warning for
> allmodconfig when we add '-Wmaybe-uninitialized':
> 
> drivers/dma/st_fdma.c: In function 'st_fdma_probe':
> drivers/dma/st_fdma.c:777:5: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> The warning is correct, though this can't happen in practice
> as the check is redundant (we don't get to this function if
> the pointer is NULL). Even if the function were called with a
> NULL of_node, the check is not needed because of_property_read_u32
> can deal with a NULL argument by returning an error.
> 
> Removing the unnecessary code simplifies the function and avoids
> the condition that we get the warning for.
> 
> Fixes: 6b4cd727eaf1 ("dmaengine: st_fdma: Add STMicroelectronics FDMA engine driver support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
