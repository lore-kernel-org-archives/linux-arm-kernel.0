From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 12 Apr 2012 09:12:22 +0530
Subject: [PATCH 2/2 v2] dma/amba-pl08x: add support for the Nomadik variant
In-Reply-To: <1334185214-27250-1-git-send-email-linus.walleij@linaro.org>
References: <1334185214-27250-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4F864F1E.8030708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2012 4:30 AM, Linus Walleij wrote:
> The Nomadik PL080 variant has some extra protection bits that
> may be set, so we need to check these bits to see if the
> channels are actually available for the DMAengine to use.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Alim Akhtar <alim.akhtar@gmail.com>
> Cc: Alessandro Rubini <rubini@gnudd.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> @@ -1917,7 +1926,7 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>  	}
>  
>  	/* Initialize physical channels */
> -	pl08x->phy_chans = kmalloc((vd->channels * sizeof(*pl08x->phy_chans)),
> +	pl08x->phy_chans = kzalloc((vd->channels * sizeof(*pl08x->phy_chans)),
>  			GFP_KERNEL);
>  	if (!pl08x->phy_chans) {
>  		dev_err(&adev->dev, "%s failed to allocate "
> @@ -1934,6 +1943,22 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
>  		spin_lock_init(&ch->lock);
>  		ch->serving = NULL;

I meant removing this one too. :)

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>
