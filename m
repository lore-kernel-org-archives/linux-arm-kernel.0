From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 29 Jul 2011 16:51:17 +0530
Subject: [PATCH 02/18] dmaengine/amba-pl08x: Resolve formatting issues
In-Reply-To: <20110729110013.GF25640@n2100.arm.linux.org.uk>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<1e5012faf0649e7ed0113960a9ac8302e46f1354.1311936524.git.viresh.kumar@st.com>
	<20110729110013.GF25640@n2100.arm.linux.org.uk>
Message-ID: <4E3297AD.5010506@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2011 04:30 PM, Russell King - ARM Linux wrote:
> On Fri, Jul 29, 2011 at 04:19:12PM +0530, Viresh Kumar wrote:
>> - Remove extra blank lines and spaces
> 
> A double space after a full-stop is standard practice for many people.
> Please don't reformat that.
> 

Ok. I didn't knew it.

>> @@ -284,7 +284,7 @@ static void pl08x_terminate_phy_chan(struct pl08x_driver_data *pl08x,
>>  	u32 val = readl(ch->base + PL080_CH_CONFIG);
>>  
>>  	val &= ~(PL080_CONFIG_ENABLE | PL080_CONFIG_ERR_IRQ_MASK |
>> -	         PL080_CONFIG_TC_IRQ_MASK);
>> +			PL080_CONFIG_TC_IRQ_MASK);
> 
> This looks worse than the original.
> 

> 
> And many more of that.
> 

Ok. Should i leave tabs and spaces mixed or just delete one tab in my change.

>>  	ret = dma_async_device_register(&pl08x->memcpy);
>>  	if (ret) {
>> -		dev_warn(&pl08x->adev->dev,
>> -			"%s failed to register memcpy as an async device - %d\n",
>> -			__func__, ret);
>> +		dev_warn(&pl08x->adev->dev, "%s failed to register memcpy as an"
>> +				" async device - %d\n", __func__, ret);
> 
> Definitely not acceptable.  Ignore warnings about wrapping 80 columns for
> kernel messages.

Ok.

-- 
viresh
