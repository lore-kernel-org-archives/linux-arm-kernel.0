From: fachkar.datawind@gmail.com (f. achkar)
Date: Thu, 27 May 2010 10:29:04 -0400
Subject: defining ARM machine type properly
In-Reply-To: <20100527010742.GH7248@trinity.fluff.org>
References: <4BFD8E7A.6050103@gmail.com>
	<20100527010742.GH7248@trinity.fluff.org>
Message-ID: <4BFE81B0.4010003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2010 09:07 PM, Ben Dooks wrote:
> On Wed, May 26, 2010 at 05:11:22PM -0400, f. achkar wrote:
>   
>> hi,
>> I'm trying to port smdk2450 arch to the a new kernel 2.6.32-9, I did the
>>     
> I suspect what you are doing is trying to port it to a machine that
> was loosley based on the SMDK2450 and that whoever did the uboot port
> failed to understand that when the hardware changes then the machine
> number needs to change too.
>   
u-boot came with the evaluation board so it is samsung's doing! however,
the u-boot correctly reports the machine type of 0x648 (corresponding to
1608 ), I suspect me wrong doing :( in setting the correct mach_type in
the linux-2.6.32-9.
>   
>> initial work as per various googled documents, but somehow the current
>> initial Image is failing at arch/arm/kernel/head-common.S :
>> '__lookup_processor_type', and eventually goes to '__error_a' of the
>> same file! this seems to be related to the definition of machine_type as
>> defined in :
>> include/asm-arm/mach-types.h  and arch/arm/tools/mach-types*
>> I checked where the definition goes in  include/asm-arm/mach-types.h by
>> inserting
>>     
> you probably wanted to enable the debugging in the head code.
>
>   
>> #error 2223XX
>> into various parts of that header and seems fine at the point.
>> nevertheless I'm not 100 sure
>> I wonder if the is a definitive reference to guide in this matter,
>> better yet a check-list like procedure??
>> thanks,
>> ferar
>>     
> How about downloading the latest kernel, with nice fresh S3C2450 support
> in it?
>   
excellent, I'll check that ... thaks
