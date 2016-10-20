From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Thu, 20 Oct 2016 18:05:15 +0200
Subject: [PATCH v2 1/6] clk: stm32f4: Add LSI & LSE clocks
In-Reply-To: <20161019202433.GA8871@codeaurora.org>
References: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
 <1476436699-21879-2-git-send-email-gabriel.fernandez@st.com>
 <20161019202433.GA8871@codeaurora.org>
Message-ID: <2e6e123e-4bb8-951c-9d49-4cb5480c37fd@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,


On 10/19/2016 10:24 PM, Stephen Boyd wrote:
> On 10/14, gabriel.fernandez at st.com wrote:
>> @@ -292,8 +298,110 @@ static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
>>   	return clks[i];
>>   }
>>   
>> +static struct regmap *pdrm;
> This can't be part of the stm32_rgate structure?
Finally i prefer not, because i need also to disable power domain write 
protection in the patch 4 (clk: stm32f4: Add RTC clock).
its will complicate the code.

BR

Gabriel
