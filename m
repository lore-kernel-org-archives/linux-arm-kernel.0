From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Apr 2018 10:36:55 +0100
Subject: [PATCH 3/3] mfd: axp20x: Correct AXP806 POK interrupt prefix
In-Reply-To: <20180329043115.7132-4-wens@csie.org>
References: <20180329043115.7132-1-wens@csie.org>
 <20180329043115.7132-4-wens@csie.org>
Message-ID: <20180416093655.d2ni7iypccl72xxu@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Mar 2018, Chen-Yu Tsai wrote:

> When AXP806 support was added, POK was incorrectly expanded to PWROK.
> However, the datasheet lists them as POK[LSNP], which is the same as
> on the AXP288. Furthermore, the registers associated with POK functions
> are the same as the PEK on the other AXP PMICs. This suggests that
> "POK" means "Power On Key", much like "PEK" means "Power Enable Key",
> instead of "Power OK".
> 
> This patch changes the "PWROK" prefix to "POK" for these interrupts.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c       | 8 ++++----
>  include/linux/mfd/axp20x.h | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
