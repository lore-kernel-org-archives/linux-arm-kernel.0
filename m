From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Jun 2011 23:04:06 +0200
Subject: [PATCH v4 3/4] drivers/amba: create devices from device tree
In-Reply-To: <1307738923-7564-4-git-send-email-robherring2@gmail.com>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
	<1307738923-7564-4-git-send-email-robherring2@gmail.com>
Message-ID: <201106102304.06279.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 June 2011 22:48:42 Rob Herring wrote:
> 
> +#ifdef CONFIG_OF
> +int of_amba_device_create(struct device_node *node, struct device *parent);
> +#endif
> +
> +#else
> +
> +#ifdef CONFIG_OF
> +static inline int of_amba_device_create(struct device_node *node, 
> +                                       struct device *parent)
> +{
> +       return 0;
> +}
> +#endif
> +

We normally don't use #ifdef around declarations like this, it doesn't
hurt to have them even when the code is not there. Otherwise the patch
looks good.

	Arnd
