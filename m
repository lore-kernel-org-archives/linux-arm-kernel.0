From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 13 Feb 2017 16:31:18 -0600
Subject: [RFC PATCH 11/33] irqchip/gic-v3-its: Split out pending table
 allocation
In-Reply-To: <1484648454-21216-12-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <659c374d-c437-4474-2c2f-4f1fd5e173dc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


On 01/17/2017 04:20 AM, Marc Zyngier wrote:
> Just as for the property table, let's move the pending table
> allocation to a separate function.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 29 ++++++++++++++++++++---------
>   1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c
> b/drivers/irqchip/irq-gic-v3-its.c
> index 14305db1..dce8f8c 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1188,6 +1188,24 @@ static int its_alloc_collections(struct its_node
> *its)
>   	return 0;
>   }
>   
> +static struct page *its_allocate_pending_table(gfp_t gfp_flags)
> +{
PEND and PROP table sizes are defined as compile time macros, but as per 
ITS spec implementation 24bit LPI space is also possible. It would be 
nicer to parametrize
both the tables sizes so that it would easier to enable 24bit LPI later.

Actually Qualcomm server chips support 24bit IDBITS.

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
