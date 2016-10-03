From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 3 Oct 2016 12:04:00 -0700
Subject: [PATCH] bus: qcom-ebi2: depend on HAS_IOMEM
In-Reply-To: <1475445239-25006-1-git-send-email-linus.walleij@linaro.org>
References: <1475445239-25006-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <e3b1a575-7f97-ed6c-e2c0-16ae193b1b49@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2016 02:53 PM, Linus Walleij wrote:
> After being asked to not depend on ARCH_QCOM* or similar,
> unsurprisingly compilation fails on UM as it has no I/O
> memory:

We could have depends on ARCH_QCOM || COMPILE_TEST and then life is
good. The HAS_IOMEM would of course stick around for compile testing.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
