From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 Dec 2011 09:34:34 +0800
Subject: [PATCH 7/7] arm/imx6q: register arm_clk to clkdev
In-Reply-To: <1323661352-10291-8-git-send-email-richard.zhao@linaro.org>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <1323661352-10291-8-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111213013433.GC10437@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 11:42:32AM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>

It's always a good practice to add some commit message even for one
line patch.  When you try to do that, you can usually find something
to note in the message.  For this particular example, you may want to
note why 'cpu_clk' needs to be in clk_lookup table.

Regards,
Shawn

> ---
>  arch/arm/mach-imx/clock-imx6q.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
> index 039a7ab..2525380 100644
> --- a/arch/arm/mach-imx/clock-imx6q.c
> +++ b/arch/arm/mach-imx/clock-imx6q.c
> @@ -1911,6 +1911,7 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK(NULL, "gpmi_io_clk", gpmi_io_clk),
>  	_REGISTER_CLOCK(NULL, "usboh3_clk", usboh3_clk),
>  	_REGISTER_CLOCK(NULL, "sata_clk", sata_clk),
> +	_REGISTER_CLOCK(NULL, "cpu_clk", arm_clk),
>  };
>  
>  int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
> -- 
> 1.7.5.4
