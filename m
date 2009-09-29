From: ben@simtec.co.uk (Ben Dooks)
Date: Tue, 29 Sep 2009 10:32:00 +0100
Subject: Discussion request for new Samsung SoCs maintaining
In-Reply-To: <4A967FB0.8090502@billgatliff.com>
References: <24498970.196691251371216483.JavaMail.weblogic@epml12>
	<4A967FB0.8090502@billgatliff.com>
Message-ID: <4AC1D410.8060604@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bill Gatliff wrote:
> Jinsung Yang wrote:
>> The second problem is that even though same family, the features like 
>> the memory map and internal devices (IPs) are very different.
>> For example, s5p6442 and s5pc110 have different arm core, but internal 
>> devices are very similar.
>> Otherwise, although s5p6440 and s5p6442 are in the same family, 
>> architecture and similar names, internal devices are very different.
>> It makes to be hard to integrate codes in a same platform directory.
[snip]
> 
> The AT91 and AVR32 SoCs have the same problem: very different cores 
> (different instruction set architectures, actually), but compatible 
> peripherals.  Their solution has been to embrace the platform and other 
> device models heavily, which I think is the appropriate one.  I think 
> this approach will work for you as well.
> 
>> So that, we are considering the following platform structure to manage 
>> our new SoCs.
>>   
> 
> Wow, your naming situation is... messed up.  :)
> 
> I'm not sure I have any useful suggestion for this part.  It would have 
> been nice to have a "mach-a8" and "mach-arm11" for these situations, but 
> we don't and I'm not sure it wouldn't cause even more problems to create 
> them.

This won't work, the processor core is pretty much independent of what goes
around it. There are parts which are very similar apart from the choice of
the ARM core in use. We try and group together the similar IP blocks that
go together to make up the chip.


-- 
Ben Dooks, Software Engineer, Simtec Electronics

http://www.simtec.co.uk/
