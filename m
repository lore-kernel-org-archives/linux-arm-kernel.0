From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Aug 2014 15:37:06 +0200
Subject: [PATCH 2/4] clk: mvebu: armada-370: Fix timer drift caused by
 the SSCG deviation
In-Reply-To: <20140829150821.66f1d03d@free-electrons.com>
References: <1409312620-20631-1-git-send-email-gregory.clement@free-electrons.com>	<1409312620-20631-3-git-send-email-gregory.clement@free-electrons.com>
 <20140829150821.66f1d03d@free-electrons.com>
Message-ID: <54008202.4090008@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 29/08/2014 15:08, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Fri, 29 Aug 2014 13:43:38 +0200, Gregory CLEMENT wrote:
> 
>> +bool a370_is_sscg_enabled(void __iomem *sar)
> 
> Minor nit: "static" is missing here.

OK I will fix it in the next version


Thanks,

Gregory


> 
>> +{
>> +	return !(readl(sar) & SARL_A370_SSCG_ENABLE);
>> +}
>> +
>>  static const struct coreclk_soc_desc a370_coreclks = {
>>  	.get_tclk_freq = a370_get_tclk_freq,
>>  	.get_cpu_freq = a370_get_cpu_freq,
>>  	.get_clk_ratio = a370_get_clk_ratio,
>> +	.is_sscg_enabled = a370_is_sscg_enabled,
>>  	.ratios = a370_coreclk_ratios,
>>  	.num_ratios = ARRAY_SIZE(a370_coreclk_ratios),
>>  };
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
