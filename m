From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 21 Oct 2013 12:09:16 +0200
Subject: [PATCH] ASoC: kirkwood: cleanup the external clock probe
In-Reply-To: <20131021085200.GW25034@n2100.arm.linux.org.uk>
References: <20131021094613.2a07bd79@armhf>
 <20131021080657.GU25034@n2100.arm.linux.org.uk>
 <20131021102834.768c0887@armhf>
 <20131021085200.GW25034@n2100.arm.linux.org.uk>
Message-ID: <20131021120916.3a3ffcf8@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Oct 2013 09:52:00 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> > > NAK.  It can occur.  
> > 
> > In which case? And, what would be the right treatment?  
> 
>         priv->clk = devm_clk_get(&pdev->dev, NULL);
>         priv->extclk = devm_clk_get(&pdev->dev, "extclk");
> 
> Supplying the first clock to this driver without a separate "extclk"
> via clkdev will return it as the second clock.
> 
> Again, NAK.  Your change is against the principles of the clk API.

You are right.

Mark, please forget about this patch.

Thanks.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
