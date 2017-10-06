From: mbrugger@suse.com (Matthias Brugger)
Date: Fri, 6 Oct 2017 15:57:57 +0200
Subject: undefined instruction d5380001 (arm64 mrs emulation)
In-Reply-To: <20171006131343.rs7ig4owz4anw3cl@armageddon.cambridge.arm.com>
References: <CAJs94EZqdWJRTF+tLgGU=pcRoU5HvuV959Qq8nFB5yQ-sQyxzg@mail.gmail.com>
 <20171002112433.GM3611@e103592.cambridge.arm.com> <59D24906.4060104@arm.com>
 <20171002155638.GA18543@e107814-lin.cambridge.arm.com>
 <CAJs94EbvM6U5qQyAGGY7BEppC=dPo_LPzU4STDNU7muCZvLXmw@mail.gmail.com>
 <fb13bcdf-c97b-40c6-3815-30dce26bca8e@suse.com>
 <20171005161645.7sqjkd25pwdng5dz@armageddon.cambridge.arm.com>
 <ffdba697-8ab5-9f66-f160-710308da6390@suse.com>
 <20171006131343.rs7ig4owz4anw3cl@armageddon.cambridge.arm.com>
Message-ID: <27e1bd48-3b6c-5dec-2fb4-cf4625ca5299@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/06/2017 03:13 PM, Catalin Marinas wrote:
> On Fri, Oct 06, 2017 at 02:05:09PM +0200, Matthias Brugger wrote:
>> On 10/05/2017 06:16 PM, Catalin Marinas wrote:
>>> On Thu, Oct 05, 2017 at 04:54:09PM +0200, Matthias Brugger wrote:
>>>> We also hit this bug in openSUSE Tumbleweed:
>>>> https://bugzilla.suse.com/show_bug.cgi?id=1061188
>>>
>>> As Mark replied, we are still debating why this happens and whether the
>>> above fix is sufficient. As we were digging further, we realised there
>>> is no clear init level after which user space can be invoked, which
>>> means Suzuki's patch may not always be sufficient.
>>>
>>> I proposed something as a way of spotting this issue early [1] but I
>>> need to post it on the linux-arch to get some consensus.
>>>
>>> Can you post the full kernel log somewhere? I'm trying to figure out
>>> what trigged the modprobe during the kernel boot.
>>>
>>
>> You can find the kernel log here:
>> https://bugzilla.suse.com/attachment.cgi?id=743311
> 
> Thanks, it seems that ipv6 module loading triggered this.
> 
> Talking to Suzuki, we came to the conclusion that such thing cannot
> happen before rootfs_initcall, so his original core_initcall change
> should suffice. I'll push a patch out, hopefully for -rc4 and cc stable.
> 

Thanks for the info.
Matthias
