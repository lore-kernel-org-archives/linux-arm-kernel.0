From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 16 Feb 2016 18:16:58 +0000
Subject: [PATCH v3 02/12] irqchip: armada-370-xp: do not enable it by
 default when ARCH_MVEBU is selected
In-Reply-To: <1454951660-13289-3-git-send-email-gregory.clement@free-electrons.com>
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
 <1454951660-13289-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160216181658.GH5183@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Gregory,

On Mon, Feb 08, 2016 at 06:14:10PM +0100, Gregory CLEMENT wrote:
> The irq-armada-370-xp driver can only be built for ARM 32 bits. The mvebu
> family had grown with a new ARM64 SoC which will also select the
> ARCH_MEVBU configuration. Since "ARM: mvebu: use the ARMADA_370_XP_IRQ
> option", the ARM32 mvebu SoC directly select this new option. Selecting
> it by default when ARCH_MEVBU is selected is no more needed.
> 
> This patch removes this dependency, thanks to this, a kernel for ARM64
> mvebu SoC can be built without error due this driver.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/irqchip/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Applied to irqchip/mvebu

thx,

Jason.
