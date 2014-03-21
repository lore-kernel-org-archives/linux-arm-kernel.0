From: b32955@freescale.com (Huang Shijie)
Date: Fri, 21 Mar 2014 13:36:12 +0800
Subject: [PATCH] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <1395235406-13449-1-git-send-email-y>
References: <1395235406-13449-1-git-send-email-y>
Message-ID: <532BCFCC.4080205@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?03?19? 21:23, y at karo-electronics.de ??:
> +	/* Set up swap_block_mark, must be set before the gpmi_set_geometry() */
> +	if (!of_property_read_bool(this->dev->of_node, "fsl,no-blockmark-swap"))
> +		this->swap_block_mark = !GPMI_IS_MX23(this);


Our ROM guy had confirmed that the Rom will disable the swapping if we 
set the DISBBM bit.
But please do not change any logic for imx23/imx28.

I really do not know what's the benefit we can get from this patch.
Please send the new version about this patch if you want this feature.


thanks
Huang Shijie
