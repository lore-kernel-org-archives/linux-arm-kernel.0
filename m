From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 Jun 2012 10:07:29 +0800
Subject: [PATCH] clk: mxs: mx23, mx28: fix clock lookup after freeing
 init memory
In-Reply-To: <1340301865-15815-1-git-send-email-mkl@pengutronix.de>
References: <1340301865-15815-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20120622020726.GC21418@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 08:04:25PM +0200, Marc Kleine-Budde wrote:
> The struct clk_lookup are marked as __initdata, resulting in beeing
> removed from memory after the kernel finished booting. However this
> leads to a NULL pointer de-ref if loading a module which uses clk_get.
> 
> This patch removes the __initdata from the struct clk_lookup.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Thanks for the fixing.  Will try to send it for -rc together with
another fixing on imx28 clock code.

Regards,
Shawn
