From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 Jan 2014 20:07:14 +0800
Subject: [PATCH] ARM: imx: Explicitly pass the active level of the PHY
 reset
In-Reply-To: <1388750156-23208-1-git-send-email-festevam@gmail.com>
References: <1388750156-23208-1-git-send-email-festevam@gmail.com>
Message-ID: <20140103120712.GE25079@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 09:55:56AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 7a399e3a2e (fec: Do not assume that PHY reset is active low), we no
> longer assume that the PHY reset is active low.
> 
> Now we need to retrieve this information from the device tree instead.
> 
> Passing '0' as the phy-reset-gpios means 'active high' according to the 
> definition from include/dt-bindings/gpio/gpio.h:
> 
> #define GPIO_ACTIVE_HIGH 0
> #define GPIO_ACTIVE_LOW 1
> 
> , so in order to keep things working as before we need to explicitly pass
> GPIO_ACTIVE_LOW as the flag.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
> Olof,
> 
> This is needed for 3.13 as 7a399e3a2e (fec: Do not assume that PHY reset is 
> active low) has already reached mainline.
> 
> This patch was generated against linus' tree.
