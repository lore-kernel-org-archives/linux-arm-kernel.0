From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 7 Sep 2010 09:40:01 +0530
Subject: [PATCH 01/74] ST SPEAr: Padmux code Updated
In-Reply-To: <20100907040748.GB30509@game.jcrosoft.org>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<90f361f70296c1762fae29a8d00d37c51b53cee2.1283161023.git.viresh.kumar@st.com>
	<20100906224901.GC8153@game.jcrosoft.org> <4C85B6CE.2080705@st.com>
	<20100907040748.GB30509@game.jcrosoft.org>
Message-ID: <4C85BB19.6070507@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/7/2010 9:37 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 09:21 Tue 07 Sep     , viresh kumar wrote:
>> On 9/7/2010 4:19 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>  
>>>>> -void spear300_pmx_init(void)
>>>>> -{
>>>>> -	spear_pmx_init(&pmx_driver, SPEAR300_SOC_CONFIG_BASE,
>>>>> +	/* pmx initialization */
>>>>> +	pmx_driver.base = ioremap(SPEAR300_SOC_CONFIG_BASE,
>>>>>  			SPEAR300_SOC_CONFIG_SIZE);
>>>>> +	if (pmx_driver.base) {
>>>>> +		ret = pmx_register(&pmx_driver);
>>>>> +		if (ret)
>>>>> +			printk(KERN_ERR "padmux: registeration failed. err no"
>>>>> +					": %d\n", ret);
>>>>> +		iounmap(pmx_driver.base);
>>> why unmap it?
>>
>> pmx_register will actually enable all selected devices and configure padmux.
>> After this we will never change device configuration again. So don't need
>> this mapping.
> so put a comment in the code
> 

Will do that.
