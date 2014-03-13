From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 13 Mar 2014 13:37:54 +0100
Subject: [PATCH v2 2/3] mfd: sec-core: Add of_compatible strings for MFD
 cells
In-Reply-To: <1394712996.20773.1.camel@AMDC1943>
References: <1394703425-6462-1-git-send-email-k.kozlowski@samsung.com>
 <1394703425-6462-3-git-send-email-k.kozlowski@samsung.com>
 <53219F80.9000300@samsung.com> <1394712996.20773.1.camel@AMDC1943>
Message-ID: <5321A6A2.9070509@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.03.2014 13:16, Krzysztof Kozlowski wrote:
> On Thu, 2014-03-13 at 13:07 +0100, Tomasz Figa wrote:
>> Hi Krzysztof,
>>
>> On 13.03.2014 10:37, Krzysztof Kozlowski wrote:
>>> Add of_compatible strings for MFD cells for regulator, clock and RTC
>>> drivers in S5M8767, S2MPS11 and S2MPS14 PMIC-s.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> ---
>>>    drivers/mfd/sec-core.c |    8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
>>> index d163c66edebb..c5b9b95b2099 100644
>>> --- a/drivers/mfd/sec-core.c
>>> +++ b/drivers/mfd/sec-core.c
>>> @@ -55,28 +55,36 @@ static const struct mfd_cell s5m8763_devs[] = {
>>>    static const struct mfd_cell s5m8767_devs[] = {
>>>    	{
>>>    		.name = "s5m8767-pmic",
>>> +		.of_compatible = "samsung,s5m8767-regulators",
>>>    	}, {
>>>    		.name = "s5m-rtc",
>>> +		.of_compatible = "samsung,s5m8767-rtc",
>>>    	}, {
>>>    		.name = "s5m8767-clk",
>>> +		.of_compatible = "samsung,s5m8767-clk",
>>>    	}
>>>    };
>>>
>>>    static const struct mfd_cell s2mps11_devs[] = {
>>>    	{
>>>    		.name = "s2mps11-pmic",
>>> +		.of_compatible = "samsung,s2mps11-regulators",
>>>    	}, {
>>>    		.name = "s2mps11-clk",
>>> +		.of_compatible = "samsung,s2mps11-clk",
>>>    	}
>>>    };
>>>
>>>    static const struct mfd_cell s2mps14_devs[] = {
>>>    	{
>>>    		.name = "s2mps14-pmic",
>>> +		.of_compatible = "samsung,s2mps14-regulators",
>>>    	}, {
>>>    		.name = "s2mps14-rtc",
>>> +		.of_compatible = "samsung,s2mps14-rtc",
>>>    	}, {
>>>    		.name = "s2mps14-clk",
>>> +		.of_compatible = "samsung,s2mps14-clk",
>>>    	}
>>>    };
>>
>> Are these compatible strings documented anywhere?
>
> The "-clk" compatible strings are (in next patch). The "-rtc" and
> "-regulators" are not.

Hmm, this doesn't sound good.

> Actually they aren't also used by child driver (each child driver parses
> from parent of_node).

Do you need to add compatible strings to mfd_cell entries of such cells 
then?

Best regards,
Tomasz
