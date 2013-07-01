From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Jul 2013 00:08:36 +0800
Subject: [PATCH v2] serial: imx: remove the uart_console() check
In-Reply-To: <1372397982-19017-1-git-send-email-b32955@freescale.com>
References: <1372397982-19017-1-git-send-email-b32955@freescale.com>
Message-ID: <20130701160833.GC14172@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 01:39:42PM +0800, Huang Shijie wrote:
> The uart_console() check makes the clocks(clk_per and clk_ipg) opened
> even when we close the console uart.
> 
> This patch enable/disable the clocks in imx_console_write(),
> so we can keep the clocks closed when the console uart is closed.
> 
> Also remove the clock enable/disable oprations in the probe, we do not
> need them any more.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
