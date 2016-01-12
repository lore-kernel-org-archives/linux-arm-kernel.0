From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 Jan 2016 08:55:33 +0900
Subject: [PATCH v3] arm: irq: l2c: do not print error in case of missing
 l2c from dtb
In-Reply-To: <1452593472-10703-1-git-send-email-andi.shyti@samsung.com>
References: <5694BABF.3070200@samsung.com>
 <1452593472-10703-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <56959275.80404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.01.2016 19:11, Andi Shyti wrote:
> In some architectures the L2 cache controller is integrated in the
> processor's block itself and it doesn't use any external cache
> controller. This means that an entry in the board's dtb related
> to the l2c is not necessary.
> 
> Distinguish between error codes and do not print anything in case
> l2x0_of_init() doesn't find any L2C DTB entry and returns -ENODEV.
> 
> This patch mutes the following error message:
> 
>    L2C: failed to init: -19
> 
> on boards like odroid-xu4, cortex A7/A15, which don't have
> external cache controller.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
> Hi,
> 
> here is a second version. An alternative would be to print with
> pr_dbg, but then it's a matter of taste.
> 
> V1, and V2 print a message in case the l2c dtb entry is not found
> (the V2 has a better print rephrase suggested by Joe)
> 
> V3 ignores the case of -enodev for l2c and doesn't print anything
> 
> Thanks,
> Andi

Looks good to me, as v2 did. Works fine:
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

BR,
KRzysztof
