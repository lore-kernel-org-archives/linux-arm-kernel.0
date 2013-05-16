From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 15 May 2013 21:34:03 -0700
Subject: [PATCH v2 1/2] clk: Disable unused clocks after deferred probing
 is done
In-Reply-To: <1368124502-18830-1-git-send-email-skannan@codeaurora.org>
References: <1368124502-18830-1-git-send-email-skannan@codeaurora.org>
Message-ID: <519461BB.3010209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2013 11:35 AM, Saravana Kannan wrote:
> With deferred probing, late_initcall() is too soon to declare a clock as
> unused. Wait for deferred probing to finish before declaring a clock as
> unused. Since deferred probing is done in late_initcall(), do the unused
> check to late_initcall_sync.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>   drivers/clk/clk.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index fe4055f..5ecb64c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -534,7 +534,7 @@ static int clk_disable_unused(void)
>
>   	return 0;
>   }
> -late_initcall(clk_disable_unused);
> +late_initcall_sync(clk_disable_unused);
>
>   /***    helper functions   ***/

Mike,

Thoughts? Picking it up? Removing the existing auto-disable code (I 
think they are still useful)?

-Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
