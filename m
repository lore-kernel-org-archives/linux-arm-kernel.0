From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 29 Oct 2013 16:20:36 -0600
Subject: [PATCH] PCI: imx6: increase link startup
In-Reply-To: <1382505138-23286-1-git-send-email-tharvey@gateworks.com>
References: <1382505138-23286-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20131029222036.GB15159@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 10:12:18PM -0700, Tim Harvey wrote:
> An increase link startup delay is required when certain PCI switches are
> attached to the root complex.  This was tested with a Pericom switch
> and a PLX switch.
> 
> From: Marek Vasut <marex@denx.de>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Acked-by: Tim Harvey <tharvey@gateworks.com>

I applied this with Shawn's ack to my pci/host-imx6 branch for v3.13,
thanks!

I assume the intent was that this patch was written by Marek, per the
"From:" line you added above, so I fixed that in the patch so Marek
appears as the author.  Let me know if this is incorrect.

> ---
>  drivers/pci/host/pci-imx6.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 90fce05..34c571a 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -318,7 +318,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
>  	while (!dw_pcie_link_up(pp)) {
>  		usleep_range(100, 1000);
>  		count++;
> -		if (count >= 10) {
> +		if (count >= 200) {
>  			dev_err(pp->dev, "phy link never came up\n");
>  			dev_dbg(pp->dev,
>  				"DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> -- 
> 1.7.9.5
> 
