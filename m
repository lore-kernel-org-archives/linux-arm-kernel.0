From: clbchenlibo.chen@huawei.com (Libo Chen)
Date: Tue, 21 May 2013 16:26:47 +0800
Subject: [PATCH 00/19] driver:usb&net: add missing platform_driver owner
In-Reply-To: <519B2993.4090409@cn.fujitsu.com>
References: <1369104120-35552-1-git-send-email-libo.chen@huawei.com>
 <20130520.232619.964940909999914694.davem@davemloft.net>
 <20130521084108.1a585f32@skate> <519B2993.4090409@cn.fujitsu.com>
Message-ID: <519B2FC7.6000801@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013/5/21 16:00, Gu Zheng wrote:
> On 05/21/2013 02:41 PM, Thomas Petazzoni wrote:
> 
>> Dear David Miller,
>>
>> On Mon, 20 May 2013 23:26:19 -0700 (PDT), David Miller wrote:
>>> From: Libo Chen <libo.chen@huawei.com>
>>> Date: Tue, 21 May 2013 10:42:00 +0800
>>>
>>>> I find a lot of mistakes using struct platform_driver without owner.
>>>> So I pick up some of them including usb and net modules
>>>
>>> Instead of doing it this way, which is obviously error prone and
>>> easy to forget, make platform_driver_register() be a macro which
>>> sets the module owner field then calls the real
>>> __platform_driver_register().
>>
>> Or, maybe make the existing module_platform_driver() macro do this?
> 
> 
> But not all the modules use module_platform_driver() macro to replace the module init/exit.
> 
> Thanks,
> Gu
> 

yes, there are many drivers register platform_driver by platform_driver_register manually.

make both platform_driver_register() and module_platform_driver()  to check and set the module owner field?



>>
>> Best regards,
>>
>> Thomas
> 
> 
> 
> .
> 
