From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 30 Jun 2016 16:18:02 +0900
Subject: [PATCH v2 1/2] clk: exynos5433: do not use CLK_IGNORE_UNUSED for
 SPI clocks
In-Reply-To: <1467032594-7643-1-git-send-email-andi.shyti@samsung.com>
References: <CGME20160627130341epcas1p23c482f5fb9e637dcda579cb874701589@epcas1p2.samsung.com>
 <1467032594-7643-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <20160630071802.GB10787@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 27, 2016 at 10:03:13PM +0900, Andi Shyti wrote:
> The CLK_IGNORE_UNUSED flag has to be avoided whenever possible.
> Use the CLK_IS_CRITICAL flag instead, which enables the clock line
> during boot time.
> 
> While none of the SCLK_SPI need to be alive all the time as that
> clock is handled by the SPI driver as a busclk whenever needed.
> 
> Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---

sorry for spamming, please ignore this patch, some more testing
has shown that if the SCLK_SPI1 is not kept alive, the device not
always works.

Thanks and sorry again,
Andi
