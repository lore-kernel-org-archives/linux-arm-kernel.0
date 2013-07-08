From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Mon, 08 Jul 2013 17:51:59 +0800
Subject: v3.10 - big endian core support
In-Reply-To: <20130708084911.GA22057@mudshark.cambridge.arm.com>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
 <51DA5089.5080109@gmail.com>
 <20130708084911.GA22057@mudshark.cambridge.arm.com>
Message-ID: <51DA8BBF.7080104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2013 04:49 PM, Will Deacon wrote:
> On Mon, Jul 08, 2013 at 06:39:21AM +0100, jgq516 at gmail.com wrote:
>> On 07/01/2013 07:03 PM, Ben Dooks wrote:
>>> The latest big-endian changes, now on:
>>>
>>> 	git://git.baserock.org/delta/linux baserock/311/be/core
>>>
>>> This has a minor fix from the last version where a rebase missed a change
>>> in the smp_scu code.
>>>
>> Hello Ben,
>>
>> Thanks for you patches at first. I can boot BE kernel on vexpress a15 tc2
>> board with LPAE disabled.
>>
>> However if enable LPAE, kernel seems hang after turn on mmu on since
>> printascii can't output any character in __mmap_switched.
>> Did you happen to try BE kernel with LPAE enabled before? or am I missed
>> something?
> Well, I hacked head.S recently to fix booting with LPAE and BE8, but I was
> unable to test early console since I was using virtio-console. It could be
> that the page table entries mapping the uart aren't quite right, but no
> obvious issues jump out from looking at the code.
Good to know you tried LPAE and BE8, and I can test the hack code if you 
wish.
> How much visibility do you have on your platform?
The printascii can output before "b __enable_mmu", after move it to
__mmap_switched, nothing can be printed. But if disable LPAE, printascii
works again in __mmap_switched.
>   Can you take a look at the page table entries and check they look ok please?
Sorry, do you mean the section of __create_page_tables? could you please 
elaborate it?

Thanks,
Xiao

> Cheers,
>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
