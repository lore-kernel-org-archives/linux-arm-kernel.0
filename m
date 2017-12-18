From: embed3d@gmail.com (Philipp Rossak)
Date: Mon, 18 Dec 2017 13:43:40 +0100
Subject: [PATCH 1/5] media: rc: update sunxi-ir driver to get base clock
 frequency from devicetree
In-Reply-To: <20171218024444.GA9140@gangnam.samsung>
References: <20171217224547.21481-1-embed3d@gmail.com>
 <CGME20171217224555epcas5p3eb77a28e9f3ba4b189c5f275e2d2a679@epcas5p3.samsung.com>
 <20171217224547.21481-2-embed3d@gmail.com>
 <20171218024444.GA9140@gangnam.samsung>
Message-ID: <887632f1-6e43-c9d0-c298-0d02b99d2781@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Andi,

thanks for the feedback. I will fix that in the next version of this 
patch series!

On 18.12.2017 03:44, Andi Shyti wrote:
> Hi Philipp,
> 
> just a couple of small nitpicks.
> 
>> +	u32 b_clk_freq;
> 
> [...]
> 
>> +	/* Base clock frequency (optional) */
>> +	if (of_property_read_u32(dn, "clock-frequency", &b_clk_freq)) {
>> +		b_clk_freq = SUNXI_IR_BASE_CLK;
>> +	}
>> +
> 
> how about you intialize 'b_clk_freq' to 'SUNXI_IR_BASE_CLK' and
> just call 'of_property_read_u32' without if statement.
> 'b_clk_freq' value should not be changed if "clock-frequency"
> is not present in the DTS.
> 
> This might avoid misinterpretation from static analyzers that
> might think that 'b_clk_freq' is used uninitialized.
> 
>> +	dev_info(dev, "set base clock frequency to %d Hz.\n", b_clk_freq);
> 
> Please use dev_dbg().
> 
> Andi
> 
--
Philipp
