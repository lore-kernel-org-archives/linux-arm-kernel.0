From: pratyush.anand@st.com (pratyush)
Date: Wed, 13 Apr 2011 17:41:14 +0530
Subject: [PATCH V7 02/17] SPEAr13xx: Add PCIe host controller base driver
	support.
In-Reply-To: <201104111722.18309.arnd@arndb.de>
References: <cover.1298977728.git.viresh.kumar@st.com>
	<201103230928.18445.arnd@arndb.de> <4DA2F36C.3010707@st.com>
	<201104111722.18309.arnd@arndb.de>
Message-ID: <4DA592E2.1060206@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

>>
>> Sorry, may be I could not get this point correctly. Do you mean that,
>> I should create a static mapping for IN0_MEM_SIZE (200 MB) and 
>> IN_IO_SIZE (20 MB) during board initialization itself?
> 
> Only IN_IO_SIZE. The I/O space is implicitly assumed to be mapped, while
> the memory space is mapped by device drivers individually.
> 

Ok.. will do it..

>>> Please reread my previous comments. You have to redefine __io() in order to make
>>> the I/O port accesses work. When you do that, you cannot define
>>> __io_address (which is used by non-PCI code) as using __io.
>>>
>>
>> __io_address is not used by PICe routines. Also, this is not part of 
>> this patch. 
> 
> Yes, that was my point.
> 

ok..

>>> Is IN_IO_SIZE per host, or this shared across all hosts?
>>
>> This is per host. So is it not a practical size?
>> What should be a reasonable IO size?
> 
> 64 KB is more than enough per host. That is the maximum that an x86 PC
> can address, so devices usually use very little of this, if anything.
> 
> There are some advantages to using 64KB combined for all hosts, but
> the easiest way should probably be to reserve 1 MB for the space
> and use 64 KB for each of them.
> 
> If you have a PCI-ISA bridge chip or a card that has one, it needs to
> be on a host that has its I/O space in the first 64 KB.
> 

I will modify, as you have suggested!!!

regards
Pratyush
