From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Dec 2015 23:08:04 +0100
Subject: [RFC PATCH 4/5] irqchip: sun4i: fix compilation outside of
 arch/arm
In-Reply-To: <1450787267-26836-5-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-5-git-send-email-andre.przywara@arm.com>
Message-ID: <201512222308.04630.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 December 2015, Andre Przywara wrote:
> The Allwinner sunxi specific interrupt controller cannot be compiled
> for any architecture except arm:
> 
> drivers/irqchip/irq-sun4i.c:25:26: fatal error: asm/mach/irq.h: No such file or directory
> compilation terminated.
> 
> It turns out that this header is actually not needed for the driver,
> so remove it and allow compilation for other architectures like
> arm64.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
