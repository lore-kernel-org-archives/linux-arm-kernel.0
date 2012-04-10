From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Apr 2012 11:47:20 +0000
Subject: [PATCHv8 05/10] ARM: dma-mapping: use
 asm-generic/dma-mapping-common.h
In-Reply-To: <1334055852-19500-6-git-send-email-m.szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201204101147.20733.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> This patch modifies dma-mapping implementation on ARM architecture to
> use common dma_map_ops structure and asm-generic/dma-mapping-common.h
> helpers.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/Kconfig                   |    1 +
>  arch/arm/include/asm/device.h      |    1 +
>  arch/arm/include/asm/dma-mapping.h |  196 +++++-------------------------------
>  arch/arm/mm/dma-mapping.c          |  148 ++++++++++++++++-----------
>  4 files changed, 115 insertions(+), 231 deletions(-)

Looks good in principle. One question: Now that many of the functions are only
used in the dma_map_ops, can you make them 'static' instead?

	Arnd
