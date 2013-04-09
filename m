From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 20:59:37 +0200
Subject: [PATCH 3/8] dmaengine: ste_dma40: Actually write the runtime
 configuration to registers
In-Reply-To: <1365532783-27425-3-git-send-email-lee.jones@linaro.org>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-3-git-send-email-lee.jones@linaro.org>
Message-ID: <201304092059.37739.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Lee Jones wrote:
> Someone has spent a fair amount of effort writing a runtime configuration
> changing algorithm for DMA clients. However, the config appears to never
> actually make it to hardware. In order for the configuration to take hold
> we need to issue a d40_config_write(), as this is the routine which writes
> it into the hardware's registers.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

So this makes the runtime_addr selection work I suppose, but the
runtime_direction still isn't used anywhere, correct?

	Arnd
