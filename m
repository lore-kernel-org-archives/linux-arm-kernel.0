From: majun258@huawei.com (majun (F))
Date: Tue, 15 Mar 2016 15:35:47 +0800
Subject: [PATCH v2 1/2] Irq/mbigen:Change the mbigen node definition in dt
 binding file
In-Reply-To: <alpine.DEB.2.11.1603140844490.3657@nanos>
References: <1457937907-14008-1-git-send-email-majun258@huawei.com>
 <1457937907-14008-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1603140844490.3657@nanos>
Message-ID: <56E7BB53.3060705@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas:
	Thanks for pointing out the problems.
I'll make detail description about this problem and resend this patch set.


? 2016/3/14 15:49, Thomas Gleixner ??:
> Majun,
> 
> On Mon, 14 Mar 2016, MaJun wrote:
> 
> First of all the prefix for irq chip drivers is not "Irq/".
> 
> Hint: git log drivers/irqchip 
> 
>> From: Ma Jun <majun258@huawei.com>
>>
>> For mbigen module, there is a special case that more than one mbigen
>> device nodes use the same reg definition in DTS when these devices
>> exist in the same mbigen hardware module.
> 
> There is a special case, so what?
>  

In current driver, the registers would be remapped repeatedly
and caused error when use the function "devm_ioremap_resource".

That's the problem I tried to fix.

>> To fix the mbigen IO remap problem, the mbigen node definition and
> 
> Which problem?
> 
>> structure are changed based on Mark Rutland's suggestion.
> 
> That's really uselss. Nobody has any idea what Mark suggested and in which way
> it fixes that unspecified problem you are talking about.
> 

Actually, I discussed this problem with Mark in v1.
He raised some questions and suggestions
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/403691.html

Thanks!
MaJun

> Thanks,
> 
> 	tglx
> 
> .
> 
