From: sdu.liu@huawei.com (Liu hua)
Date: Sun, 4 May 2014 10:34:38 +0800
Subject: [PATCH v3 0/2] change ARM linux memory layout to support 32 CPUs
In-Reply-To: <alpine.LFD.2.11.1404221949510.980@knanqh.ubzr>
References: <1397559967-26050-1-git-send-email-sdu.liu@huawei.com>
 <20140422213114.GA24070@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1404221949510.980@knanqh.ubzr>
Message-ID: <5365A73E.1060006@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/4/23 7:50, Nicolas Pitre wrote:
> On Tue, 22 Apr 2014, Russell King - ARM Linux wrote:
> 
>> On Tue, Apr 15, 2014 at 07:06:05PM +0800, Liu Hua wrote:
>>> This patch series change fixmap mapping region to suppport 32 CPUs.
>>> Because the "top_pmd" covers 0xfffe0000 - 0xffffffff(2M). And part 
>>> is used by vector table. So I move this region down to 0xffc00000
>>>  - 0xffdffff. 
>>
>> Can you explain why you have submitted these patches to my patch tracker
>> with a copy to stable at vger.kernel.org ?
>>
>> What makes these qualify for stable tree inclusion?  What regression are
>> they fixing?
>>
>> We don't put patches into the stable tree for things that /never/ worked
>> in the past.  We've never supported 32 CPUs so I don't think these
>> qualify.
> 
> Indeed.  The stable qualifier should be dropped.
> 
> 
> Nicolas
> 
> .
> 
I am very sorry to ignore this mail for ten days! We have a platform of 16
CPUs, for which these patches are necessary(15CPUs for old memory layout).
But only with these patches, the ARM linux can not run on it.(gic part
should also be changed)

So you are right. It seems to be a new feature. Sorry for this mistake.
If anything I should do, please inform me!

Thanks,
Liu Hua
