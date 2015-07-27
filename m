From: majun258@huawei.com (majun (F))
Date: Mon, 27 Jul 2015 10:25:05 +0800
Subject: [PATCH v3 1/3] IRQ/Gic-V3: Add mbigen driver to support mbigen
 interrupt controller
In-Reply-To: <55A7B3A5.6010008@arm.com>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
 <1436166548-34920-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1507061248090.3916@nanos> <559CA530.2090508@huawei.com>
 <559D3EB5.4060408@arm.com> <55A76CBE.2030508@huawei.com>
 <55A770E2.2040300@arm.com> <55A777BD.4080504@huawei.com>
 <55A77999.9000203@arm.com> <55A7A2F9.3000306@huawei.com>
 <55A7B3A5.6010008@arm.com>
Message-ID: <55B59681.2090008@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc

? 2015/7/16 21:37, Marc Zyngier ??:
[...]
>>
>> For example, An device with total 5 interrupts connected to Mbigen node.
>> In mbigen chip, the default eventID value for each device starts from 0.
>> So, for these 5 interrupts the default eventID value is from 0 to 4.
>>
>> Because the default eventID is fixed in mbigen chip, to make these 5 interrupt
>> work, the only way is define all these 5 interrupts in dts file.
> 
> But the ITS doesn't read these interrupts, and won't let you program the
> translation either.
> 
>> When irq initializing, ITS driver will allocat LPI interrupt number for these
>> 5 interrupts, for example : from 8192 to 8196. and the eventID value is from 0 to 4.
>> Now, the allocated eventID value same as the eventID value encoded in mbigen chip,
>> The interrupt can work.
> 
> But that's pure luck! What if I decide to change the allocation method
> so that all the devices share a common ITT?
> 
> Have you really hardcoded the Linux behaviour in your hardware?
> 
>> I know this is not a good method,but for current mbigen chip,it's the only solution.
> 
> I'm sorry, I can't call this a solution.
Yes,you are right. This is not a right way to solve the problem.
This problem will be fixed in next version chip.

> 
> 	M.
> 
