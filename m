From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 06 Nov 2018 09:35:51 -0800
Subject: [PATCH V2] clk: imx7d: remove UART1 clock setting
In-Reply-To: <1539910863-2352-1-git-send-email-Anson.Huang@nxp.com>
References: <1539910863-2352-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <154152575127.88331.11571189328688525045@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anson Huang (2018-10-18 18:05:36)
> There are clock assignments in all i.MX7D dtb files for UART1,
> below is the example in imx7d-sdb.dts, so setting UART1 clock
> in clock driver is NOT necessary, actually, module clocks setting
> should be done in module driver.
> 
> &uart1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_uart1>;
>         assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
>         assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
>         status = "okay";
> };
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next
