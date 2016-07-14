From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 14 Jul 2016 10:11:29 -0400 (EDT)
Subject: [PATCH] usb: ehci-platform: use helper variables in probe function
In-Reply-To: <1468398548-5050-1-git-send-email-zajec5@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1607141008500.32397-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jul 2016, Rafa? Mi?ecki wrote:

> Probing function was using &dev->dev and dev->dev.of_node over 20 times
> so I believe it made sense to use helper variables for both of them.
> To avoid some uncommon variable name for struct device I first replaced
> existing dev variable with pdev.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Okay except for...

> -		priv->num_phys = of_count_phandle_with_args(dev->dev.of_node,
> -				"phys", "#phy-cells");
> +		priv->num_phys = of_count_phandle_with_args(np, "phys",
> +							    "#phy-cells");

Please indent continuation lines two tab stops beyond the original 
line, to match the style in the rest of the source file.

With that change,

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
