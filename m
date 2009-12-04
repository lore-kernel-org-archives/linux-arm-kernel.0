From: hs@denx.de (Heiko Schocher)
Date: Fri, 04 Dec 2009 16:58:43 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091204154231.GB20386@n2100.arm.linux.org.uk>
References: <4B18F141.7070101@denx.de>
	<20091204131307.GE15887@n2100.arm.linux.org.uk>
	<4B1911B4.7080907@denx.de>
	<20091204154231.GB20386@n2100.arm.linux.org.uk>
Message-ID: <4B1931B3.90301@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell King,

Russell King - ARM Linux wrote:
> On Fri, Dec 04, 2009 at 02:42:12PM +0100, Heiko Schocher wrote:
>> Hello Russell King,
>>
>> Russell King - ARM Linux wrote:
>>> On Fri, Dec 04, 2009 at 12:23:45PM +0100, Heiko Schocher wrote:
>>>> [4] Log from Demoprogramm, not working
>>> I think this is messed up - this is not from your first script but your
>>> second script which starts four independent read processes.
>>>
>>> I determined this because:
>>> (1) the read thread addresses are mostly the same
>>> (2) there are four "Read form in_msg" strings, which you only print
>>> once at the start of the program.
>> Ups, sorry for the confusion, here 2 logs with the right values:
> 
> I don't remember whether 2.6.28 has highmem.  Can you check whether you're
> using highmem please?

No, there is no HIGHMEM in the defconfig, if you mean this config option.

You can find the complete defconfig here:

http://git.denx.de/?p=linux-2.6-denx.git;a=blob;f=arch/arm/configs/suen3_defconfig;h=905f9bc6a36c03ab41b97a292fca5b3a0011a2a0;hb=3dc3e4dc957f216ec5cdcd2a770f5c4b0cefca4a

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
