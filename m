From: robherring2@gmail.com (Rob Herring)
Date: Wed, 24 Oct 2012 07:39:53 -0500
Subject: [PATCH v2 2/2] ARM: topdown mmap support
In-Reply-To: <CAMj5Bkg9Ht4YG9TL4yQfT5y5Fea4ywLDANoO2NTnGJZatN2RLQ@mail.gmail.com>
References: <1321566426-31184-1-git-send-email-robherring2@gmail.com>
 <1321566426-31184-2-git-send-email-robherring2@gmail.com>
 <CAMj5Bkg9Ht4YG9TL4yQfT5y5Fea4ywLDANoO2NTnGJZatN2RLQ@mail.gmail.com>
Message-ID: <5087E199.4050704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2012 07:22 AM, zhangfei gao wrote:
> On Fri, Nov 18, 2011 at 5:47 AM, Rob Herring <robherring2@gmail.com> wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Similar to other architectures, this adds topdown mmap support in user
>> process address space allocation policy. This allows mmap sizes greater
>> than 2GB. This support is largely copied from MIPS and the generic
>> implementations.
>>
>> The address space randomization is moved into arch_pick_mmap_layout.
>>
>> Tested on V-Express with ubuntu and a mmap test from here:
>> https://bugs.launchpad.net/bugs/861296
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Unfortunately, we met "no vspace available" during loading libmono.so,
> when using default arch_get_unmapped_area_topdown method, tested on
> Jelly Bean with 3.4 kernel.
> While no problem using arch_get_unmapped_area in the patch, or just
> revert this patch.
> The result is some application can not run.
> 
> Just google, find same issue reported on Jelly Bean with 3.4 kernel.
> 
> Any suggestion?

Perhaps Android has hardcoded expectations about the virtual memory
layout? I was worried about that at the time and asked the Linaro
Android folks to test it.

I believe either layout can be selected at runtime per process. I don't
recall the exact /proc file to control this.

Rob
