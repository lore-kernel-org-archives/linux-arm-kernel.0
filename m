From: peter.chen@nxp.com (Peter Chen)
Date: Wed, 2 Nov 2016 06:45:57 +0000
Subject: [PATCH 3/3] clk: imx: clk-imx6ul: add clk support for imx6ull
In-Reply-To: <20161102001205.GA16026@codeaurora.org>
References: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
 <1477969343-19887-4-git-send-email-peter.chen@nxp.com>
 <20161102001205.GA16026@codeaurora.org>
Message-ID: <HE1PR04MB14508C014D6370FBC875B9508BA00@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>
>On 11/01, Peter Chen wrote:
>>  	clks[IMX6UL_CLK_USDHC1]		= imx_clk_gate2("usdhc1",
>	"usdhc1_podf",	 base + 0x80,	2);
>>  	clks[IMX6UL_CLK_USDHC2]		= imx_clk_gate2("usdhc2",
>	"usdhc2_podf",	 base + 0x80,	4);
>> -	clks[IMX6UL_CLK_SIM1]		= imx_clk_gate2("sim1",
>	"sim_sel",	 base + 0x80,	6);
>> -	clks[IMX6UL_CLK_SIM2]		= imx_clk_gate2("sim2",
>	"sim_sel",	 base + 0x80,	8);
>> +	if (clk_on_imx6ul()) {
>> +		clks[IMX6UL_CLK_SIM1]		= imx_clk_gate2("sim1",
>	"sim_sel",	 base + 0x80,	6);
>> +		clks[IMX6UL_CLK_SIM2]		= imx_clk_gate2("sim2",
>	"sim_sel",	 base + 0x80,	8);
>> +	}
>>  	clks[IMX6UL_CLK_EIM]		= imx_clk_gate2("eim",
>	"eim_slow_podf", base + 0x80,	10);
>>  	clks[IMX6UL_CLK_PWM8]		= imx_clk_gate2("pwm8",
>	"perclk",	 base + 0x80,	16);
>>  	clks[IMX6UL_CLK_UART8_IPG]	= imx_clk_gate2("uart8_ipg",	"ipg",
>	 base + 0x80,	14);
>> @@ -430,6 +478,7 @@ static void __init imx6ul_clocks_init(struct device_node
>*ccm_node)
>>  	clk_set_rate(clks[IMX6UL_CLK_ENET_REF], 50000000);
>>  	clk_set_rate(clks[IMX6UL_CLK_ENET2_REF], 50000000);
>>  	clk_set_rate(clks[IMX6UL_CLK_CSI], 24000000);
>> +	clk_set_rate(clks[IMX6UL_CLK_PLL3_PFD2], 320000000);
>
>Can you use assigned clock rates for this instead?
>

Thanks, I will move it to dts.

Peter
