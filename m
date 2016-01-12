From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Jan 2016 17:28:55 +0900
Subject: [PATCH v2] arm: irq: l2c: do not print error in case of missing
 l2c from dtb
In-Reply-To: <1452583474-11729-1-git-send-email-andi.shyti@samsung.com>
References: <1452582683.7773.102.camel@perches.com>
 <1452583474-11729-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <5694B947.7040207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.01.2016 16:24, Andi Shyti wrote:
> In some architectures the L2 cache controller is integrated in the
> processor's block itself and it doesn't use any external cache
> controller. This means that an entry in the board's dtb related
> to the l2c is not necessary.
> 
> Distinguish between error codes and print just an information in
> case of -ENODEV.
> 
> This patch converts the following error message:
> 
>    L2C: failed to init: -19
> 
> to the following info:
> 
>    L2C: no controller entry found in the dtb
> 
> on boards like odroid-xu4, cortex A7/A15, which don't have
> external cache controller.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
> 
> Thanks Joe,
> 
> makes sense!
> 
> Andi
> 
>  arch/arm/kernel/irq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Works (Odroid XU3, Exynos5422) and looks good for me:

Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
