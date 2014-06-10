From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 10 Jun 2014 13:59:25 -0500
Subject: [PATCH] mmc: sdhci-msm: Fix fallout from sdhci refactoring
In-Reply-To: <1402424839-25514-1-git-send-email-sboyd@codeaurora.org>
References: <1402424839-25514-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <BB4C39AE-74FB-4F10-B08C-CA036C11F1D5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jun 10, 2014, at 1:27 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

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
> ---
> 
> Patch based on next-20140610
> 
> drivers/mmc/host/sdhci-msm.c | 4 ++++
> 1 file changed, 4 insertions(+)

Acked-by: Kumar Gala <galak@codeaurora.org>

Feel free to pick up this version of the patch and ignore mine.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
