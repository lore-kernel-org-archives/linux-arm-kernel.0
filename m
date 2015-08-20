From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 20 Aug 2015 16:57:08 +0800
Subject: [PATCH] ARM: imx: mach-imx6ul: Fix allmodconfig build
In-Reply-To: <1440009090-25799-1-git-send-email-festevam@gmail.com>
References: <1440009090-25799-1-git-send-email-festevam@gmail.com>
Message-ID: <20150820085707.GA9137@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 03:31:30PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> We should call phy_register_fixup_for_uid() only when CONFIG_PHYLIB
> is built-in, otherwise we get the following link error when building
> allmodconfig:
> 
> arch/arm/mach-imx/built-in.o: In function `imx6ul_init_machine':
> :(.init.text+0xa714): undefined reference to `phy_register_fixup_for_uid'
> 
> This is the same approach done in mach-imx6q.c and mach-imx6sx.c.
> 
> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks, Fabio.

Acked-by: Shawn Guo <shawnguo@kernel.org>

Olof,

I suppose that you will pick up the fix directly.  Let me know if you
think differently.  Thanks.

Shawn
