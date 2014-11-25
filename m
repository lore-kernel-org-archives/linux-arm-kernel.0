From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Nov 2014 12:24:16 -0800
Subject: [PATCH] ARM: orion: convert the irq_reg_{readl, writel} calls to
 the new API
In-Reply-To: <1416928752-24529-1-git-send-email-gregory.clement@free-electrons.com>
References: <1416928752-24529-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAOesGMiPkmX=o6ALPYGmF9Z9iY=YQyQMgC82pGF3X+ediv7=gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 7:19 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> The commit "genirq: Generic chip: Change irq_reg_{readl,writel}
> arguments" modified the API. In the same tome the
> arch/arm/plat-orion/gpio.c file received a fix with the use of the old
> API: "ARM: orion: Fix for certain sequence of request_irq can cause
> irq storm". This commit fixes the use of the API.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi Jason,
>
> This patch fix a build error in linux-next:
>
> arch/arm/plat-orion/gpio.c:509:12: error: too few arguments to function 'irq_reg_readl'
> arch/arm/plat-orion/gpio.c:511:2: error: too few arguments to function 'irq_reg_writel'
> arch/arm/plat-orion/gpio.c:523:12: error: too few arguments to function 'irq_reg_readl'
> arch/arm/plat-orion/gpio.c:525:2: error: too few arguments to function 'irq_reg_writel'
>
> But if we want to apply it on the mvebu branch we need to add a
> dependecy to "332fd7c4fef5 genirq: Generic chip: Change
> irq_reg_{readl,writel} arguments"

Please take this through the same repo as the change in the prototype:

Acked-by: Olof Johansson <olof@lixom.net>



-Olof
