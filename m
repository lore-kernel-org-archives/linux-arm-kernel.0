From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 10 Jun 2014 12:41:59 -0700
Subject: [PATCH] mmc: sdhci-msm: Fix fallout from sdhci refactoring
In-Reply-To: <1402424839-25514-1-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Tue, 10 Jun 2014 11:27:19 -0700")
References: <1402424839-25514-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <7hzjhko8l4.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> The sdhci core was refactored recently and some of those
> refactorings required changes in every sdhci platform driver.
> Those updates happened around the same time as when the msm
> driver was merged so the refactorings missed the msm driver.
> Hook in the basic library functions so that we can boot apq8074
> dragonboards again instead of crashing when we try to jump to
> NULL function pointers.
>
> Reported-by: Kevin Hilman <khilman@linaro.org>
> Cc: Georgi Djakov <gdjakov@mm-sol.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Tested-by: Kevin Hilman <khilman@linaro.org>

I verifed that this patch on top of next-20140610 gets the qcom
dragonboard booting again.

Kevin
