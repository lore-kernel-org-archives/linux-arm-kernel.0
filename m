From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Jul 2014 10:41:10 +0200
Subject: [PATCH v3 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <1405499166-6726-8-git-send-email-antoine.tenart@free-electrons.com>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405499166-6726-8-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <42036198.zWkqnus6xa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 July 2014 10:26:01 Antoine T?nart wrote:
> +
> +       if (priv->dma_mask) {
> +               ret = dma_coerce_mask_and_coherent(&pdev->dev, priv->dma_mask);
> +               if (ret)
> +                       return ret;
> +       }
> +
> 

As mentioned in my comment for the binding, this is the wrong way to do it.
Russell has in the past converted all drivers that did this manually to 
do dma_coerce_mask_and_coherent() so we can spot them more easily, but we
should really be doing this better for new drivers.

Can you describe what the restriction is that you want to put on the dma mask?

	Arnd
