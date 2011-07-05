From: rdunlap@xenotime.net (Randy Dunlap)
Date: Tue, 5 Jul 2011 16:27:05 -0700
Subject: [PATCH v4] mmc: documentation of mmc non-blocking request usage
	and design.
In-Reply-To: <1309901732-3735-1-git-send-email-per.forlin@linaro.org>
References: <1309901732-3735-1-git-send-email-per.forlin@linaro.org>
Message-ID: <20110705162705.c3081299.rdunlap@xenotime.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  5 Jul 2011 23:35:32 +0200 Per Forlin wrote:

> +MMC block driver
> +================
> +
> +The issue_rw_rq() in the MMC block driver is made non-blocking.
> +The increase in throughput is proportional to the time it takes to
> +prepare (major part of preparations are dma_map_sg and dma_unmap_sg)
> +a request and how fast the memory is. The faster the MMC/SD is
> +the more significant the prepare request time becomes. Roughly the expected
> +performance gain is 5% for large writes and 10% on large reads on a L2 cache
> +platform. In power save mode, when clocks run on a lower frequency, the DMA
> +preparation may cost even more. As long as these slower preparations are run
> +in parallel with the transfer performance wont be affected.

                                             won't

Acked-by: Randy Dunlap <rdunlap@xenotime.net>


thanks.
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
