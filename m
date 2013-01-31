From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 31 Jan 2013 22:54:54 +0100
Subject: ixp4xx eth broken in 3.7.0/3.8-rc5?
In-Reply-To: <20744.25884.660535.514911@pilspetsen.it.uu.se> (Mikael
 Pettersson's message of "Wed, 30 Jan 2013 01:11:08 +0100")
References: <20744.9777.937924.822371@pilspetsen.it.uu.se>
 <20744.25884.660535.514911@pilspetsen.it.uu.se>
Message-ID: <m3622duifl.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson <mikpe@it.uu.se> writes:

>  > When I try to update my ixp4xx machine to a 3.8-rc5 kernel it boots
>  > Ok but the network (CONFIG_IXP4XX_ETH=y) fails to come up, with the
>  > following in the kernel log:
>  >
>  > net eth0: coherent DMA mask is unset
>
> A git bisect identified the following as the culprit:
>
>  > From 1a4901177574083c35fafc24c4d151c2a7c7647c Mon Sep 17 00:00:00 2001
>  > From: Xi Wang <xi.wang@gmail.com>
>  > Date: Sat, 17 Nov 2012 20:25:09 +0000
>  > Subject: [PATCH] ixp4xx_eth: avoid calling dma_pool_create() with NULL dev
>  >
>  > Use &port->netdev->dev instead of NULL since dma_pool_create() doesn't
>  > allow NULL dev.

IIRC NULL dev in dma_pool_create() meant the usual IXP4xx mask (64MB)
was used. Perhaps devices don't get a mask by default anymore. I will
look at this in few days.
-- 
Krzysztof Halasa
