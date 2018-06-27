From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 27 Jun 2018 14:26:00 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <942e76b6-a46a-6c5e-5ec3-67daca636d43@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com>
 <942e76b6-a46a-6c5e-5ec3-67daca636d43@arm.com>
Message-ID: <5B339068.5020304@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 2018/6/27 9:39, James Morse wrote:
> Hi Wei,
> 
> On 26/06/18 18:47, Will Deacon wrote:
>> On Wed, Jun 27, 2018 at 01:16:44AM +0800, Wei Xu wrote:
>>>     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
>>>     [    0.000000] Linux version 4.18.0-rc2-58583-g7daf201-dirty
>>
>> I'm still suspicious that this is 4.18-rc2 with "no change on top" ^^^ !
> 
> Some examples:
> 
> For comparison, when I boot v4.17 it looks like this:
> | Linux version 4.17.0 (morse at melchizedek) (gcc version 4.9.3 20141031
> | (prerelease) (Linaro GCC 2014.11)) #9886 SMP PREEMPT Thu Jun 21 10:30:55 BST
> | 2018
> 
> 
> If I apply some extra patches and make some uncommitted changes, it looks like this:
> | Linux version 4.17.0-00025-ga22ca2234824-dirty (morse at melchizedek) (gcc
> | version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11)) #9887 SMP PREEMPT
> | Thu Jun 21 10:46:22 BST 2018
> 
> 
> Hence we read your '4.17.0-45864-g29dcea8-dirty' line as v4.17 with extra
> patches and uncommited changes, and similar with this v4.18-rc2.
> 
> I agree 7daf201 is the head commit for v4.18-rc2, but something has gone wrong
> here. Could you try building from a fresh clone of Linus' tree?
> 
> (I suspect at some point you've applied a patch, and have then been merging
> upstream, instead of 'fast forwarding')
> 

Thanks for your kindly guidance!
Sorry, I should highlight that I have only updated the default value
of CONFIG_NR_CPUS by menuconfig in the previous mail.
That is why it showed dirty.

Best Regards,
Wei

> 
> 
> Thanks,
> 
> James
> 
> .
> 
