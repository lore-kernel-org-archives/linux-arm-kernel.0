From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 1 Oct 2017 17:12:58 +0200
Subject: [PATCH] omap_ssi_core: fix kilo to be "k" not "K"
In-Reply-To: <20170923190838.GA16966@amd>
References: <20170923190838.GA16966@amd>
Message-ID: <20171001151258.du7jdx3kqkswrp6r@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Sep 23, 2017 at 09:08:38PM +0200, Pavel Machek wrote:
> 
> Kilo should be "k" not "K", fix it it comments and messages.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Thanks, queued.

-- Sebastian

> index 88e48b3..41a09f5 100644
> --- a/drivers/hsi/controllers/omap_ssi_core.c
> +++ b/drivers/hsi/controllers/omap_ssi_core.c
> @@ -334,7 +334,7 @@ static int ssi_clk_event(struct notifier_block *nb, unsigned long event,
>  	case POST_RATE_CHANGE:
>  		dev_dbg(&ssi->device, "post rate change (%lu -> %lu)\n",
>  			clk_data->old_rate, clk_data->new_rate);
> -		omap_ssi->fck_rate = DIV_ROUND_CLOSEST(clk_data->new_rate, 1000); /* KHz */
> +		omap_ssi->fck_rate = DIV_ROUND_CLOSEST(clk_data->new_rate, 1000); /* kHz */
>  
>  		for (i = 0; i < ssi->num_ports; i++) {
>  			omap_port = omap_ssi->port[i];
> @@ -467,9 +467,9 @@ static int ssi_hw_init(struct hsi_controller *ssi)
>  	}
>  	/* Resetting GDD */
>  	writel_relaxed(SSI_SWRESET, omap_ssi->gdd + SSI_GDD_GRST_REG);
> -	/* Get FCK rate in KHz */
> +	/* Get FCK rate in kHz */
>  	omap_ssi->fck_rate = DIV_ROUND_CLOSEST(ssi_get_clk_rate(ssi), 1000);
> -	dev_dbg(&ssi->device, "SSI fck rate %lu KHz\n", omap_ssi->fck_rate);
> +	dev_dbg(&ssi->device, "SSI fck rate %lu kHz\n", omap_ssi->fck_rate);
>  
>  	writel_relaxed(SSI_CLK_AUTOGATING_ON, omap_ssi->sys + SSI_GDD_GCR_REG);
>  	omap_ssi->gdd_gcr = SSI_CLK_AUTOGATING_ON;
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171001/e55de115/attachment.sig>
