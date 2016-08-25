From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 25 Aug 2016 16:28:22 +0900
Subject: [PATCH 1/2] clk: samsung: exynos5260: Move struct samsung_cmu_info
 to init section
In-Reply-To: <20160825001109.GO19826@codeaurora.org>
References: <1471834185-20249-1-git-send-email-cw00.choi@samsung.com>
 <1471834185-20249-2-git-send-email-cw00.choi@samsung.com>
 <CGME20160823005523epcas1p3993794ba487bb055cbf8a0b247fcb280@epcas1p3.samsung.com>
 <20160823005512.GP6502@codeaurora.org> <57BBB66E.2060807@samsung.com>
 <84e40b9b-1e08-24e0-f1ef-60b38b760ae6@samsung.com>
 <20160824044346.GR6502@codeaurora.org> <57BD5CFB.5050500@samsung.com>
 <20160825001109.GO19826@codeaurora.org>
Message-ID: <57BE9E16.7090309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 2016? 08? 25? 09:11, Stephen Boyd wrote:
> On 08/24, Chanwoo Choi wrote:
>> On 2016? 08? 24? 13:43, Stephen Boyd wrote:
>>> On 08/23, Sylwester Nawrocki wrote:
>>>> So the saving is rather insignificant but the patch doesn't make
>>>> things worse and I'd say it might be worth applying.
>>>>
>>>
>>> Sounds good. This sort of information should be in the commit
>>> text though. Talking about const doesn't make any sense to me.
>>
>> Do you mean that 'const' is initconst secion?
> 
> No. Marking it as initconst in the patch is correct.

OK.

> 
>> If possible, could you explain the anything
>> why you don't make sense about 'const'?
>>
> 
> I'm just saying that the reasoning to move it from the text
> section to the data section shouldn't be because of const. There
> should be better reasons to do this, like size benefits.
> 

As I already said, the samsung_cmu_register_on() requires
the 'const' type argument for 'struct samsung_cmu_info'.

So, I defined the instance on the out of the exynos5260_clk_aud_init() as following:
	static const struct samsung_cmu_info aud_cmu __initconst = {

How can i add the 'const' keyword and '__initsecion' to the 
"struct samsung_cmu_info aud_cmu" in the "static void __init 
exynos5260_clk_aud_init(struct device_node *np)"?

-- 
Best Regards,
Chanwoo Choi
