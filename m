From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 23 Oct 2014 16:48:15 +0200
Subject: [BISECTED] arm: mvebu: Kernel hang after ae9304c9d311 if
 OF_SELFTEST=y
In-Reply-To: <5448EB5E.3010405@free-electrons.com> (Gregory CLEMENT's message
 of "Thu, 23 Oct 2014 13:49:50 +0200")
References: <87mw8nt5io.fsf@natisbad.org> <5448EB5E.3010405@free-electrons.com>
Message-ID: <87h9yuu9jk.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> On 23/10/2014 13:00, Arnaud Ebalard wrote:
>> Hi,
>> 
>> Trying to boot a 3.17.1 (same thing w/ current tip of Linus tree or
>> 3.17.1) on two Marvell Armada 370 based platforms (NETGEAR ReadyNAS
>> 102 and Synology DS213j) ends up w/ the following:
>> 
>>    Starting kernel ...
>>    
>>    Uncompressing Linux... done, booting the kernel.
>>    
>>    Error: unrecognized/unsupported machine ID (r1 = 0x00000bde).
>>    
>>    Available machine support:
>>    
>>    ID (hex)        NAME
>>    ffffffff        Generic DT based system
>>    ffffffff        Marvell Armada 380/385 (Device Tree)
>>    ffffffff        Marvell Armada 375 (Device Tree)
>>    ffffffff        Marvell Armada 370/XP (Device Tree)
>>    
>>    Please check your kernel config and/or bootloader.
>> 
>> I bisected it up to ae9304c9d31117 ("Adding selftest testdata
>> dynamically into live tree"). For a while, my kernels are compiled w/
>> OF_SELFTEST and it works w/o issue. After that commit, boot hangs as
>
> It would be interesting to have a feedback of a kernel with an appended dtb
> and OF_SELFTEST enabled to a different platform (ie non mvebu). Then we
> will know if it something related to mvebu or to the device tree support.
>
> I will try to see if I can do this.

I can test that on a kirkwood (6282) this evening.

Cheers,

a+
