From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 2 Apr 2015 10:19:41 -0700
Subject: [PATCH 0/6] selftests: improve cross compilation support
In-Reply-To: <551D49C8.3040900@osg.samsung.com>
References: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
 <551D49C8.3040900@osg.samsung.com>
Message-ID: <CANMBJr4388KONsn4K_y2-1S0LtYURTFSc3AQakZk8Fhp-PCrBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shuah,

On 2 April 2015 at 06:53, Shuah Khan <shuahkh@osg.samsung.com> wrote:
> On 04/01/2015 05:20 PM, Tyler Baker wrote:
>> This patch set improves cross building functionality by resovling hard coded
>> assumptions about the compiler used. With this patch set, all but mqueue,
>> and kdbus cross build successfully as they must link against a native
>> libraries. The hope is tha the above issues can be resolved in future patch
>> sets. I have tested this series by building selftests for x86_64, arm and
>> arm64 targets.
>>
>> This motivation behind this series is to enable the kernelci.org service to
>> easily build, deploy, and execute selftests on many different processor
>> architectures without natively compiling them. With the hope of quickly
>> providing these test results back to the community.
>>
>> This series is based on next-20150401.
>>
>> Tyler Baker (6):
>>   selftest/memfd: enable cross compilation
>>   selftest/kdbus: enable cross compilation
>>   selftest/mount: enable cross compilation
>>   selftest/memfd: include default header install path
>>   selftest/ipc: enable cross compilation
>>   selftest/mqueue: enable cross compilation
>>
>>  tools/testing/selftests/ipc/Makefile    | 6 +-----
>>  tools/testing/selftests/kdbus/Makefile  | 4 ++--
>>  tools/testing/selftests/memfd/Makefile  | 8 +++++---
>>  tools/testing/selftests/mount/Makefile  | 5 +++--
>>  tools/testing/selftests/mqueue/Makefile | 6 ++++--
>>  5 files changed, 15 insertions(+), 14 deletions(-)
>>
>
>
> Tyler,
>
> Thanks for getting this work done. It is a bit late for
> 4.1 and I plan to get these into 4.2.

Thank you for your consideration, apologies for sending this series
late in the merge window. Having these patches included in 4.2 sounds
fine to me.

>
> thanks,
> -- Shuah
>
> --
> Shuah Khan
> Sr. Linux Kernel Developer
> Open Source Innovation Group
> Samsung Research America (Silicon Valley)
> shuahkh at osg.samsung.com | (970) 217-8978

Cheers,

Tyler
