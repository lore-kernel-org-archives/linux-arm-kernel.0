From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Thu, 02 Apr 2015 12:47:59 -0600
Subject: [PATCH 0/6] selftests: improve cross compilation support
In-Reply-To: <551D7B2D.3020703@osg.samsung.com>
References: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
 <551D49C8.3040900@osg.samsung.com> <551D7B2D.3020703@osg.samsung.com>
Message-ID: <551D8EDF.8080609@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2015 11:23 AM, Shuah Khan wrote:
> On 04/02/2015 07:53 AM, Shuah Khan wrote:
>> On 04/01/2015 05:20 PM, Tyler Baker wrote:
>>> This patch set improves cross building functionality by resovling hard coded
>>> assumptions about the compiler used. With this patch set, all but mqueue, 
>>> and kdbus cross build successfully as they must link against a native 
>>> libraries. The hope is tha the above issues can be resolved in future patch 
>>> sets. I have tested this series by building selftests for x86_64, arm and 
>>> arm64 targets.
>>>
>>> This motivation behind this series is to enable the kernelci.org service to
>>> easily build, deploy, and execute selftests on many different processor
>>> architectures without natively compiling them. With the hope of quickly
>>> providing these test results back to the community.
>>>
>>> This series is based on next-20150401.
>>>
>>> Tyler Baker (6):
>>>   selftest/memfd: enable cross compilation
>>>   selftest/kdbus: enable cross compilation
>>>   selftest/mount: enable cross compilation
>>>   selftest/memfd: include default header install path
>>>   selftest/ipc: enable cross compilation
>>>   selftest/mqueue: enable cross compilation
>>>
>>>  tools/testing/selftests/ipc/Makefile    | 6 +-----
>>>  tools/testing/selftests/kdbus/Makefile  | 4 ++--
>>>  tools/testing/selftests/memfd/Makefile  | 8 +++++---
>>>  tools/testing/selftests/mount/Makefile  | 5 +++--
>>>  tools/testing/selftests/mqueue/Makefile | 6 ++++--
>>>  5 files changed, 15 insertions(+), 14 deletions(-)
>>>
>>
>>
>> Tyler,
>>
>> Thanks for getting this work done. It is a bit late for
>> 4.1 and I plan to get these into 4.2.
>>
> 
> After taking a second look at the patches, I want to get
> these into 4.1. It will be nice to enable cross compile
> as well in this release.
> 
> The one patch I won't be able to take it through kselftest
> tree is kdbus for logistical reasons. kdbus is going through
> Greg's tree - one of his many trees :)
> 
> Greg!
> 
> Will you be able to include this kdbus patch in this series
> in your pull request for kdbus. I will reply to the kdbus
> patch in this series and cc you on that. If this doesn't
> work, could you suggest an alternative.
> 

All patches except the kdbus patch are now in linux-kselftest next
for 4.1

thanks,
-- Shuah


-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh at osg.samsung.com | (970) 217-8978
