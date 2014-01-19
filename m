From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 19 Jan 2014 10:49:50 +0800
Subject: [PATCH V8 1/3] ARM: imx: add suspend in ocram support for i.mx6q
In-Reply-To: <1389929947-25707-1-git-send-email-b20788@freescale.com>
References: <1389929947-25707-1-git-send-email-b20788@freescale.com>
Message-ID: <20140119024948.GC16158@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 11:39:05AM +0800, Anson Huang wrote:
> When system enter suspend, we can set the DDR IO to
> high-Z state to save DDR IOs' power consumption, this
> operation can save many power(from ~26mA at 1.5V to ~15mA at 1.5V,
> measured on i.MX6Q SabreSD board, R25) of DDR IOs. To
> achieve that, we need to copy the suspend code to ocram
> and run the low level hardware related code(set DDR IOs
> to high-Z state) in ocram.
> 
> If there is no ocram space available, then system will
> still do suspend in external DDR, hence no DDR IOs will
> be set to high-Z.
> 
> The OCRAM usage layout is as below,
> 
> ocram suspend region(4K currently):
> ======================== high address ======================
>                               .
>                               .
>                               .
>                               ^
>                               ^
>                               ^
>                       imx6_suspend code
>              PM_INFO structure(imx6_cpu_pm_info)
> ======================== low address =======================
> 
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Anson Huang <b20788@freescale.com>

Thanks for the work.  Applied all 3, thanks.
