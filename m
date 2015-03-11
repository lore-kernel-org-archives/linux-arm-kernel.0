From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 Mar 2015 11:29:25 +0100
Subject: [PATCH v2] ARM: EXYNOS: Fix failed second suspend on Exynos4
In-Reply-To: <1426069206-13667-1-git-send-email-k.kozlowski@samsung.com>
References: <1426069206-13667-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1426069765.30407.7.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2015-03-11 at 11:20 +0100, Krzysztof Kozlowski wrote:
> On Exynos4412 boards (Trats2, Odroid U3) after enabling L2 cache in
> 56b60b8bce4a ("ARM: 8265/1: dts: exynos4: Add nodes for L2 cache
> controller") the second suspend to RAM failed. First suspend worked fine
> but the next one hang just after powering down of secondary CPUs (system
> consumed energy as it would be running but was not responsive).
> 
> The issue was caused by enabling delayed reset assertion for CPU0 just
> after issuing power down of cores. This was introduced for Exynos4 in
> 13cfa6c4f7fa ("ARM: EXYNOS: Fix CPU idle clock down after CPU off").
> 
> The whole behavior is not well documented but after checking with vendor
> code this should be done like this (on Exynos4):
> 1. Enable delayed reset assertion when system is running (for all CPUs).
> 2. Disable delayed reset assertion before suspending the system.
>    This can be done after powering off secondary CPUs.
> 3. Re-enable the delayed reset assertion when system is resumed.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: 13cfa6c4f7fa ("ARM: EXYNOS: Fix CPU idle clock down after CPU off")
> Cc: <stable@vger.kernel.org>
> Tested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

Dear Kukjin,

This patch was first sent on 3rd of February. It could enter before
opening 4.0 merge window. I did not receive any response from you in
that time.

So let me point next steps:
1. The Exynos4412 suspend on 4.0 is broken and now this patch applies as
a fix.
2. I resent it on 18th of February.
3. I received tested-by from Bartlomiej and Chanwoo.
4. Bartlomiej pinged you on 3rd March.

Still no response. If the patch does not look good then please share
your comments. I'll fix it.
If this patch looks good, why does it take so much time?


Dear Arnd and Olof,

Could you pick it up to your arm-soc?


Best regards,
Krzysztof
