From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 12 Apr 2016 13:25:10 +0200
Subject: [PATCH 5/7] clk: samsung: exynos542x: Add the clock id for ACLK
In-Reply-To: <1460091646-28701-6-git-send-email-cw00.choi@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-6-git-send-email-cw00.choi@samsung.com>
Message-ID: <570CDB16.2050001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
> This patch adds the clock id for ACLK clock which is source clock of AMBA AXI
> Bus. This clock should be handled in Bus frequency scaling driver.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 85 +++++++++++++++++++++++-------------
>  1 file changed, 55 insertions(+), 30 deletions(-)

The IDs itself look good but you are not adding only clock ID. You are
changing all of them from NULL-flags to CLK_SET_RATE_PARENT. This should
be explained in the commit message why you need it. Probably it should
be also in separate commit.

Best regards,
Krzysztof
