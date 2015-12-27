From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 27 Dec 2015 23:04:33 +0100
Subject: [RFC PATCH 4/5] irqchip: sun4i: fix compilation outside of
 arch/arm
In-Reply-To: <1450787267-26836-5-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-5-git-send-email-andre.przywara@arm.com>
Message-ID: <20151227220433.GU30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 22, 2015 at 12:27:46PM +0000, Andre Przywara wrote:
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

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151227/65bacc72/attachment.sig>
