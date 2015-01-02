From: nm@ti.com (Nishanth Menon)
Date: Fri, 2 Jan 2015 09:36:03 -0600
Subject: [PATCH v10 2/8] ARM: l2c: Refactor the driver to use commit-like
 interface
In-Reply-To: <54A664AB.1060100@gmail.com>
References: <1419331716-8972-1-git-send-email-m.szyprowski@samsung.com>	<1419331716-8972-3-git-send-email-m.szyprowski@samsung.com>	<54A19C17.1020909@ti.com>
 <CA+Ln22G3kVA_-tsjAxbe2rqSHeLtdU2X_EhNL0uW3cUCgaWLgg@mail.gmail.com>
 <54A2BBDC.1020900@ti.com> <54A66143.2080506@gmail.com>
 <54A664AB.1060100@gmail.com>
Message-ID: <54A6BAE3.70204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2015 03:28 AM, Tomasz Figa wrote:
> 
> 
> On 02.01.2015 18:13, Tomasz Figa wrote:
>> On 30.12.2014 23:51, Nishanth Menon wrote:
>>>>> Looks like the following also need addressing:
>>>>> data->save is called twice (once more after l2cof_init)
>>>>> l2c310_init_fns also needs l2c310_configure
>>>>> will be nice to use l2x0_data only after we kmemdup data in __l2c_init
>>>>
>>>> I'll check this.
>>> Thanks.
>>>
>>
>> Apparently the second save in __l2c_init() is not needed and it should
>> have been removed. However it might be a good idea to actually do second
>> save in l2c_enable() after l2c_configure() so that the values actually
>> permitted by hardware and/or secure firmware are stored.
>>
>> l2c310_init_fns needs to be updated indeed.
> 
> Hmm, apparently current patch already adds this (and I missed it reading 
> it at first), so I'm not sure what's your concern about it.

Uggh.. looks like I missed the same as well :( Sorry about that..



-- 
Regards,
Nishanth Menon
