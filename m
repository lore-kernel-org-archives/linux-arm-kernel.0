From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 27 Dec 2012 10:41:50 +0530
Subject: [PATCH 1/6 v9] arm: use devicetree to get smp_twd clock
In-Reply-To: <1354833773-22845-2-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354833773-22845-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354833773-22845-2-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <50DBD896.8040706@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 December 2012 04:12 AM, Mark Langsdorf wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> ---
> Changes from v4, v5, v6, v7, v8
>          None.
> Changes from v3
>          No longer setting *clk to NULL in twd_get_clock().
> Changes from v2
>          Turned the check for the node pointer into an if-then-else statement.
>          Removed the second, redundant clk_get_rate.
> Changes from v1
>          None.
>
>   arch/arm/kernel/smp_twd.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)

Hi Mark,

What is the status of this patch?

Regards,
PrashantG

> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index b22d700..af46b80 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -237,12 +237,15 @@ static irqreturn_t twd_handler(int irq, void *dev_id)
>   	return IRQ_NONE;
>   }
>
