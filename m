From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 29 Oct 2014 16:54:04 +0000
Subject: [PATCHv3 2/5] arm64: Add AArch32 instruction set condition code
 checks
In-Reply-To: <20141029152148.GM27405@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 29 Oct 2014 15:21:48 +0000")
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-4-git-send-email-punit.agrawal@arm.com>
 <20141029152148.GM27405@n2100.arm.linux.org.uk>
Message-ID: <9hhfve6g6kz.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for having a look.

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, Oct 27, 2014 at 06:40:04PM +0000, Punit Agrawal wrote:
>>  arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
>> -					   sys_compat.o
>> +					   sys_compat.o 			\
>> +					   $(addprefix ../../arm/kernel/,	\
>> +						opcodes.o)
>
> This is not particularly nice.  While it means that this file gets built
> on both arm64 and arm, it means that it routinely won't get tested on
> arm64 when changes to it happen.

I agree. An earlier version of this patch copied opcodes.c to arm64 but
then it wouldn't benefit from any fixes that would go in the
original. The current approach misses out on the testing. Although
better than the previous approach, it is not optimal.

>
> The second reason it's not nice is that the whole $(addprefix thing
> really isn't needed.  You're only adding the prefix to one name.  So,
> a simpler way to write it is "../../arm/kernel/opcodes.o".

This one is easy to make nice. Fixed in my local copy.

Cheers,
Punit
