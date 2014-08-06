From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 06 Aug 2014 10:40:35 +0800
Subject: [PATCH v3 4/5] clk: hix5hd2: add ir clocks
In-Reply-To: <1406884874-30406-5-git-send-email-zhangfei.gao@linaro.org>
References: <1406884874-30406-1-git-send-email-zhangfei.gao@linaro.org>
 <1406884874-30406-5-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <53E195A3.6040605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/01/2014 05:21 PM, Zhangfei Gao wrote:
> From: Guoxiong Yan <yanguoxiong@huawei.com>
>
> hix5hd2 add ir clocks
>
> Signed-off-by: Guoxiong Yan <yanguoxiong@huawei.com>


Sorry, this patch should be droped.
IR clock register is not in the same region as others.
Will update.

Thanks
> ---
>   drivers/clk/hisilicon/clk-hix5hd2.c       |    5 +++++
>   include/dt-bindings/clock/hix5hd2-clock.h |    2 ++
>   2 files changed, 7 insertions(+)
>
> diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
> index d6a2189..21f32d9 100644
> --- a/drivers/clk/hisilicon/clk-hix5hd2.c
> +++ b/drivers/clk/hisilicon/clk-hix5hd2.c
> @@ -100,6 +100,11 @@ static struct hisi_gate_clock hix5hd2_gate_clks[] __initdata = {
>   		CLK_SET_RATE_PARENT, 0x178, 0, 0, },
>   	{ HIX5HD2_WDG0_RST, "rst_wdg0", "clk_wdg0",
>   		CLK_SET_RATE_PARENT, 0x178, 4, CLK_GATE_SET_TO_DISABLE, },
> +	/* ir */
> +	{ HIX5HD2_IR_CLK, "clk_ir", "24m",
> +		CLK_SET_RATE_PARENT, 0x48, 4, 0, },
> +	{ HIX5HD2_IR_RST, "rst_ir", "clk_ir",
> +		CLK_SET_RATE_PARENT, 0x48, 5, CLK_GATE_SET_TO_DISABLE, },
>   };
>
>   enum hix5hd2_clk_type {
> diff --git a/include/dt-bindings/clock/hix5hd2-clock.h b/include/dt-bindings/clock/hix5hd2-clock.h
> index b8e3c9d..6aa4fec 100644
> --- a/include/dt-bindings/clock/hix5hd2-clock.h
> +++ b/include/dt-bindings/clock/hix5hd2-clock.h
> @@ -62,6 +62,8 @@
>   #define HIX5HD2_SD_CIU_RST		138
>   #define HIX5HD2_WDG0_CLK		139
>   #define HIX5HD2_WDG0_RST		140
> +#define HIX5HD2_IR_CLK			141
> +#define HIX5HD2_IR_RST			142
>
>   /* complex */
>   #define HIX5HD2_MAC0_CLK		192
>
