From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 18 Sep 2013 12:18:39 -0400
Subject: [PATCH] arm: mvebu: use the main timer as clock source from DT
In-Reply-To: <1379519624-4267-1-git-send-email-jean.pihet@linaro.org>
References: <1379519624-4267-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <20130918161839.GN19937@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 05:53:44PM +0200, Jean Pihet wrote:
> This commit:
>   573145f08c2b92c45498468afbbba909f6ce6135
>   clocksource: armada-370-xp: Use CLOCKSOURCE_OF_DECLARE
> 
> replaced a call to the driver's timer initialization by a call to
> clocksource_of_init(). However, it failed to select CONFIG_CLKSRC_OF.
> 
> Fix this by selecting CONFIG_CLKSRC_OF for Armada370/XP machines.
> Without this change the kernel is stuck at: 'Calibrating delay loop...'.
> 
> Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
> Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/fixes

thx,

Jason.
