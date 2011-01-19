From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 19 Jan 2011 09:33:01 +0530
Subject: [PATCH V4 04/62] ST SPEAr: Making clock functions more generic
In-Reply-To: <20110118155620.GB16980@n2100.arm.linux.org.uk>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<70889215d9aa6c1c3ad604763d7b831865fe3eb5.1295333957.git.viresh.kumar@st.com>
	<20110118155620.GB16980@n2100.arm.linux.org.uk>
Message-ID: <4D366275.9030007@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2011 09:26 PM, Russell King - ARM Linux wrote:
> On Tue, Jan 18, 2011 at 12:41:32PM +0530, Viresh Kumar wrote:
>>  /* pll1 configuration structure */
>>  static struct pll_clk_config pll1_config = {
>>  	.mode_reg = PLL1_CTR,
>>  	.cfg_reg = PLL1_FRQ,
>> +	.masks = &pll1_masks,
>>  };
>>  
>>  /* PLL1 clock */
> ...
>> -	mode = (readl(config->mode_reg) >> PLL_MODE_SHIFT) &
>> -		PLL_MODE_MASK;
>> +	mode = (readl(config->mode_reg) >> config->masks->mode_shift) &
>> +		config->masks->mode_mask;
>>  
> ...
>>  struct pll_clk_config {
>> -	unsigned int *mode_reg;
>> -	unsigned int *cfg_reg;
>> +	u32 *mode_reg;
>> +	u32 *cfg_reg;
>> +	struct pll_clk_masks *masks;
>>  };
> 
> Registers should have an __iomem attribute on them.  Preferably, but
> not absolutely necessary, should be void to prevent any direct
> dereferencing.
> .
> 

Yes, it should be void __iomem *

-- 
viresh
