From: jemmajones81@yahoo.co.uk (Jemma Jones)
Date: Tue, 8 May 2012 11:13:36 +0100 (BST)
Subject: Development tree for Cortex-A15?
In-Reply-To: <4f7e5540dd597d8e48fb81a5e1e26313@localhost>
References: <1336046199.46241.YahooMailNeo@web132501.mail.ird.yahoo.com>
 <bc6e93f98278125c354282f23751b1aa@localhost>
 <1336052155.37772.YahooMailNeo@web132504.mail.ird.yahoo.com>
 <6e4ad6defa33bf693ec45cae819469f0@localhost>
 <1336121047.79153.YahooMailNeo@web132504.mail.ird.yahoo.com>
 <e8545d06e2a63b7b2badc24d8bc1531f@localhost>
 <1336134008.88695.YahooMailNeo@web132504.mail.ird.yahoo.com>
 <4f7e5540dd597d8e48fb81a5e1e26313@localhost>
Message-ID: <1336472016.29885.YahooMailNeo@web132503.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: Development tree for Cortex-A15?

> 
> On Fri, 4 May 2012 13:20:08 +0100 (BST), Jemma Jones
> <jemmajones81@yahoo.co.uk> wrote:
>>>  Subject: Re: Development tree for Cortex-A15?
>>> 
>>>  On Fri, 4 May 2012 09:44:07 +0100 (BST), Jemma Jones
>>>  <jemmajones81@yahoo.co.uk> wrote:
>>>>> ? Subject: Re: Development tree for Cortex-A15?
>>>> 
>>>>> 
>>>>> ? On Thu, 3 May 2012 14:35:55 +0100 (BST), Jemma Jones
>>>>> ? <jemmajones81@yahoo.co.uk> wrote:
>>>>>>>  ? Subject: Re: Development tree for Cortex-A15?
>>>>>> 
>>>>>>  ? I'm currently on kvm-arm-v7-ael, because it looked 
> like the 
>>>  most
>>>>>>  ? up-to-date one. Which one should I be using for 
> Cortex-A15 
>>>  support?
>>>>> 
>>>>> ? That branch is good enough, if you have a bleeding edge QEMU. 
> Note
>>>>> ? that
>>>>> ? the VE A15 support in that tree is DT only. I'm working on 
> a v3.4 
>>>  based
>>>>> ? one
>>>>> ? at the moment, but that's not completely ready yet.
>>>> 
>>>> ? I'm just a little confused because under 
> arch/arm/mach-vexpress/
> there
>>>  is
>>>> ? no A15 tile? On the virtualopensystems.com git (which you quote
> above)
>>>  you
>>>> ? had to explicitly enable the board and it would show up in the
> .config
>>>  as
>>>> ? CONFIG_ARCH_VEXPRESS_CA15X4. Is that not the case anymore in your
>>>> ? kernel
>>>> ? tree?
>>> 
>>>  No. The ARM tree in general is moving to the device tree, and
>>>  CONFIG_ARCH_VEXPRESS_CA15X4 was always meant as a temporary hack until
>>>  the
>>>  VE-DT port was mature enough to be used.
>>> 
>>>  As Pawe?'s DT work has been merged into 3.4, there is strictly no
> reason
>>>  to keep this hack around, and my recent trees do reflect that fact
>>>  (kvm-arm-v7-ael and kvm-arm-3.4). Christoffer may decide to keep this
> in
>>>  his tree during a transition period, but CONFIG_ARCH_VEXPRESS_CA15X4 is
>>>  dead as far as I am concerned.
>>> 
>>>  If you're just starting to play with KVM-ARM now, please don't 
> rely on 
>>>  the
>>>  A15 board file, it is a dead end.
>> 
>>  Any chance you can send me a .config file that works on the kernel in
> this
>>  branch which runs on your A15x1 FastModel?
> 
> Coming in a private email.

I didn't seem to get anything?

?
>>  I'm using the boot-wrapper from
>>  http://git.linaro.org/gitweb?p=arm/models/boot-wrapper.git;a=summary in
>>  semi hosting mode.
>> 
>>  I managed to boot Android from that but I don't seem to be able to boot
>>  your kernel. It just stops after the boot-wrapper says loading uImage.
> 
> Which dts file are you using?

I don't quite understand yet how the DT stuff is used. When I build the DTB files then I get vexpress-v2p-ca15-tc1.dtb in my arch/arm/boot directory. I assume that one is used then for my kernel image?

My .config has all the DT stuff enabled I think:
CONFIG_ARCH_VEXPRESS_DT=y
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y

Or is that not correct?

I have now updated to you latest kvm-arm-3.4 branch.

But the kernel still does not boot up properly, or at least I don't seem to get any output. It just goes "Uncompressing Linux... done." and then does nothing.
I'm using the FastModel Cortex-A15x2 simulation.

Cheers
Jemma
