From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 18:19:46 +0200
Subject: [PATCH 4/5] dmaengine: ste_dma40: Only configure a channel during
 a configure request
In-Reply-To: <1365434591-21569-4-git-send-email-lee.jones@linaro.org>
References: <1365434591-21569-1-git-send-email-lee.jones@linaro.org>
 <1365434591-21569-4-git-send-email-lee.jones@linaro.org>
Message-ID: <201304081819.46377.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Lee Jones wrote:
> According to the DMA documentation allocating a channel and configuring
> it are two separate actions. By moving the configuration code into the
> correct code path we lighten the burden on the information required to
> successfully allocate a channel.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I think the patch doesn't match the description. You only remove
the calls to configure the channel but don't add it in a proper
place.

	Arnd
