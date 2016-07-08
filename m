From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 08 Jul 2016 15:24:44 +0200
Subject: [PATCH v5] clk: exynos5433: remove CLK_IGNORE_UNUSED flag from SPI
 clocks
In-Reply-To: <1467982058-14339-1-git-send-email-andi.shyti@samsung.com>
References: <1467982058-14339-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <577FA99C.9020600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2016 02:47 PM, Andi Shyti wrote:
> Commit b82ec4e and a9e93e8 have added support in the spi device
> driver for the three clock lines required by the SPI controller
> and handles the dependency between the three (by not disabling
> any after resume).
> 
> This way none of the SPI clocks require any criticality: remove,
> then the CLK_IGNORE_UNUSED flag for the SPI related clocks.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
> 
> Hi,
> 
> With this, I hope to have reached the end of this patch series :)
> 
> After some discussions with Tomasz first and Sylwester later, we
> agreed to move all the clock management to the spi driver, here
> are the patches that do that:
> 
>   http://marc.info/?l=linux-kernel&m=146787645626318&w=2
>   http://marc.info/?l=linux-kernel&m=146798033221943&w=2
> 
> With the above modifications to the spi driver we don't need any
> of the SPI related clocks to be marked either as critical or as
> ignore unused.
> 
> Thanks,
> Andi
> 
>  drivers/clk/samsung/clk-exynos5433.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Patch is okay:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

but I think this should not go in separately. This should be part of
SPI-related changes which add proper ioclk consumer to the SPI driver.
Without these changes, as you said to me, synchronous abort will happen.

Best regards,
Krzysztof
