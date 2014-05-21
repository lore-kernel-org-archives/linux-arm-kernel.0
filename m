From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 May 2014 17:23:41 +0200
Subject: [PATCH v8 0/2] Add support for the Allwinner A31 DMA Controller
In-Reply-To: <1400685357-508-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1400685357-508-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <4828893.NoTbcUXQEt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 May 2014 17:15:54 Maxime Ripard wrote:
> Changes from v7:
>   - select DMA_OF, since we're only relying on DT
> 

I missed the discussion about this issue, but it seems wrong to me.
DMA_OF is currently enabled if we have both DMAENGINE and OF turned on.

If OF is disabled but DMA_OF gets selected by DMA_SUN6I, what happens?

	Arnd
