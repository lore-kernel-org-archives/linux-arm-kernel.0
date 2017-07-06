From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Thu, 6 Jul 2017 09:33:00 +0200
Subject: [PATCH 2/2] rtc: stm32: add STM32H7 RTC support
In-Reply-To: <20170705213746.6hf5af57ty6wsfgs@piout.net>
References: <1498470689-26829-1-git-send-email-amelie.delaunay@st.com>
 <1498470689-26829-3-git-send-email-amelie.delaunay@st.com>
 <20170705213746.6hf5af57ty6wsfgs@piout.net>
Message-ID: <ebe3f3f0-263d-cf6c-6b6e-2f37ab435c88@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/05/2017 11:37 PM, Alexandre Belloni wrote:
> Hi,
> 
> This is mostly fine, even if I'm not too happy with the
> s/ck_rtc/rtc_ck/.
> 
This clock name has changed in datasheet between STM32F4/STM32F7 and 
STM32H7, so, I'm not really happy too... But, as there is only one clock 
on F4/F7, its name is not important for the end user. Now that pclk 
appears, we need to distinguish the two clocks, and for the end user, it 
is better if the clock names match the datasheet.

> On 26/06/2017 at 11:51:29 +0200, Amelie Delaunay wrote:
>> -	rtc->ck_rtc = devm_clk_get(&pdev->dev, NULL);
>> -	if (IS_ERR(rtc->ck_rtc)) {
>> -		dev_err(&pdev->dev, "no ck_rtc clock");
>> -		return PTR_ERR(rtc->ck_rtc);
>> +	match = of_match_device(stm32_rtc_of_match, &pdev->dev);
>> +	if (match && match->data)
>> +		rtc->data = (struct stm32_rtc_data *)match->data;
>> +	else
>> +		return -EINVAL;
> 
> This will never happen, you can remove that test.
> 
> 
OK, will be done in V2.

Thanks for the review,
Amelie
