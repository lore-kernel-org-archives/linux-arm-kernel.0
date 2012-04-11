From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Apr 2012 00:05:58 +0100
Subject: [PATCH 2/2 v2] dma/amba-pl08x: add support for the Nomadik variant
In-Reply-To: <1334185214-27250-1-git-send-email-linus.walleij@linaro.org>
References: <1334185214-27250-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120411230558.GF24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 01:00:14AM +0200, Linus Walleij wrote:
> The Nomadik PL080 variant has some extra protection bits that
> may be set, so we need to check these bits to see if the
> channels are actually available for the DMAengine to use.

Actually, there is another issue to be considered with PL080.  For memcpy
transfers, a restricted set of channels should be used, because the PL080
only guarantees certain channels won't consume all bus bandwidth, locking
out (eg) the CPU from doing other stuff while the memcpy DMA is running.

So really the way physical channels are selected needs to become more
inteligent overall.
