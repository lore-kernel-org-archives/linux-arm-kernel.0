From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 8 Nov 2013 15:54:04 +0000
Subject: [PATCH 2/2] mfd: max77693: reorder params in API for regmap
 consistency
In-Reply-To: <1383923118-26921-2-git-send-email-k.kozlowski@samsung.com>
References: <1383923118-26921-1-git-send-email-k.kozlowski@samsung.com>
 <1383923118-26921-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131108155404.GA30901@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 08 Nov 2013, Krzysztof Kozlowski wrote:

> The last two parameters of certain register access functions were in
> different order than regmap API. This was confusing and error-prone.
> 
> Reorder parameters for register access API to match regmap API:
>  - max77693_bulk_read() reorder count and buf,
>  - max77693_bulk_write() reorder count and buf,
>  - max77693_update_reg() reorder val and mask.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/extcon/extcon-max77693.c     |   14 +++++++-------
>  drivers/mfd/max77693-irq.c           |    2 +-
>  drivers/mfd/max77693.c               |    6 +++---
>  include/linux/mfd/max77693-private.h |   10 +++++-----
>  4 files changed, 16 insertions(+), 16 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
