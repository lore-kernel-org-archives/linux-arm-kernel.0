From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 10 May 2013 08:45:20 +0200
Subject: [PATCH v2 1/2] clk: Disable unused clocks after deferred
 probing is done
In-Reply-To: <1368124502-18830-1-git-send-email-skannan@codeaurora.org>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
 <1368124502-18830-1-git-send-email-skannan@codeaurora.org>
Message-ID: <20130510064520.GI3041@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:35 Thu 09 May     , Saravana Kannan wrote:
> With deferred probing, late_initcall() is too soon to declare a clock as
> unused. Wait for deferred probing to finish before declaring a clock as
> unused. Since deferred probing is done in late_initcall(), do the unused
> check to late_initcall_sync.

Nack for both regulator & clk

you can not known when the clock need to be shutdown

example display splash screen set by the bootloader and display as module

Best Regards,
J.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  drivers/clk/clk.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index fe4055f..5ecb64c 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -534,7 +534,7 @@ static int clk_disable_unused(void)
>  
>  	return 0;
>  }
> -late_initcall(clk_disable_unused);
> +late_initcall_sync(clk_disable_unused);
>  
>  /***    helper functions   ***/
>  
> -- 
> 1.7.8.3
> 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
