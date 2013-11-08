From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 8 Nov 2013 15:52:02 +0000
Subject: [PATCH 1/2] mfd: sec: reorder params in API for regmap consistency
In-Reply-To: <1383923118-26921-1-git-send-email-k.kozlowski@samsung.com>
References: <1383923118-26921-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131108155202.GZ30901@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 08 Nov 2013, Krzysztof Kozlowski wrote:

> The last two parameters of certain register access functions were in
> different order than regmap API. This was confusing and error-prone.
> 
> Reorder parameters for register access API to match regmap API:
>  - sec_bulk_read() reorder count and buf,
>  - sec_bulk_write() reorder count and buf,
>  - sec_reg_update() reorder val and mask.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mfd/sec-core.c           |    6 +++---
>  drivers/regulator/s5m8767.c      |   26 +++++++++++++-------------
>  include/linux/mfd/samsung/core.h |    6 +++---
>  3 files changed, 19 insertions(+), 19 deletions(-)

Seems to make sense.

For the MFD portion: Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
