From: hemantp@ti.com (Pedanekar, Hemant)
Date: Mon, 8 Aug 2011 21:18:45 +0530
Subject: [PATCH 2/4] TI816X: clock: Add clock data
In-Reply-To: <alpine.DEB.2.00.1107160201410.25013@utopia.booyaka.com>
References: <1301070006-8363-1-git-send-email-hemantp@ti.com>
	<alpine.DEB.2.00.1107160201410.25013@utopia.booyaka.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03ABB09340@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Paul Walmsley wrote on Saturday, July 16, 2011 1:36 PM:

> Spot-checking this...
> 
> On Fri, 25 Mar 2011, Hemant Pedanekar wrote:
> 
>> +static struct clk uart1_fck = {
>> +	.name		= "uart1_fck",
>> +	.parent		= &sysclk10_ck,
>> +	.ops		= &clkops_omap2_dflt,
>> +	.enable_reg	= TI816X_CM_ALWON_UART_0_CLKCTRL,
>> +	.enable_bit	= TI816X_MODULEMODE_SWCTRL,
>> +	.clkdm_name	= "alwon_l3_slow_clkdm",
>> +	.recalc		= &followparent_recalc,
>> +};
> 
> Is this really in the alwon_l3_slow_clkdm clockdomain?
> Looking at SPRS680
> section 5.2 "L4 Interconnect", these UARTs seem to be in some L4
> clockdomain? 
> 
> 
> - Paul

Yes UARTs are on L4 slow but the clock domain is labelled as 
ALWON_L3_SLOW. Please refer 18.3.2 of SPRUGX8 (TRM from http://focus.ti.com/docs/prod/folders/print/tms320dm8168.html).

Thanks.
   Hemant
