From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 23 Jan 2015 17:22:23 -0600
Subject: [PATCH] PCI: xgene: Include clk.h instead of clk-private.h
In-Reply-To: <1421954754-3217-1-git-send-email-sboyd@codeaurora.org>
References: <1421954754-3217-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150123232223.GU29776@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 11:25:54AM -0800, Stephen Boyd wrote:
> This driver should be including clk.h as it's a clock consumer,
> not a clock provider that needs to register clocks early.
> 
> Cc: Tanmay Inamdar <tinamdar@apm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Applied provisionally to pci/host-xgene for v3.20, thanks!

I'm hoping for an ack from Tanmay.

> ---
>  drivers/pci/host/pci-xgene.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index b1d0596457c5..fdb348d3ccd3 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -16,7 +16,7 @@
>   * GNU General Public License for more details.
>   *
>   */
> -#include <linux/clk-private.h>
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/jiffies.h>
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
