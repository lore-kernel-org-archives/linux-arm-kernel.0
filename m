From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 28 Jun 2018 11:20:35 +0100
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <9549e15d-4ec6-8dd3-2237-b6c9b52fc816@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com>
 <942e76b6-a46a-6c5e-5ec3-67daca636d43@arm.com>
 <5B339068.5020304@hisilicon.com>
 <9549e15d-4ec6-8dd3-2237-b6c9b52fc816@arm.com>
Message-ID: <5B34B673.20803@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 2018/6/28 9:45, James Morse wrote:
> Hi Wei,
> 
> On 27/06/18 14:26, Wei Xu wrote:
>> Sorry, I should highlight that I have only updated the default value
>> of CONFIG_NR_CPUS by menuconfig in the previous mail.
>> That is why it showed dirty.
> 
> (menuconfig changes don't show up like this)

Thanks!
Sorry, yes, you are right.
I did not see dirty after I reset the proc.S.

> 
> 
> More than 64 CPUs ... Is this system running more VMs than it has VMIDs? Too-few
> VMIDs does work with KVM, its just going to trigger rollover frequently.
>

No, we just ran one VM.

> Just to check, what kernel version is the host running? Does it have commit
> f0cf47d939d0 ("KVM: arm/arm64: Close VMID generation race")
> (looks like that went in as a fix for v4.17-rc3)

Yes, the host is runing 4.18-rc2 as the guest including above commit.

> 
> Are you running (lots) of other VMs whenever this happens? Do they have multiple
> vcpus? (I'm thinking of the scenario in that patch's description)

No, we just ran one VM with 1 cpu.

> 
> Is the host system otherwise idle when this happens?
> (If not, can you reproduce the issue without exhausting the VMIDs?)
> 
> 
> It may be that writing back the page-table entries with the MMU off, and
> changing the cache maintenance are just changing the timing of something else.
> 

Yes, maybe. Now we are debugging with the SoC guys together.
Thanks!

Best Regards,
Wei

> 
> Thanks,
> 
> James
> 
> .
> 
