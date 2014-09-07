From: behanw@converseincode.com (Behan Webster)
Date: Sat, 06 Sep 2014 19:28:19 -0700
Subject: [PATCH] arm64: LLVMLinux: Provide __aeabi_* symbols which are
 needed for clang
In-Reply-To: <2954780.2t9bpyu7ov@wuerfel>
References: <1409959394-14936-1-git-send-email-behanw@converseincode.com>
 <2954780.2t9bpyu7ov@wuerfel>
Message-ID: <540BC2C3.1070509@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/14 07:16, Arnd Bergmann wrote:
> On Friday 05 September 2014 16:23:14 behanw at converseincode.com wrote:
>> --- /dev/null
>> +++ b/arch/arm64/lib/eabi.c
>> @@ -0,0 +1,32 @@
>> +/*
>> + *  linux/lib/eabi.c
> Please don't put the file names in the files themselves, it's redundant
> and in this case actually wrong.
Will fix.

>> + *  Copyright (C) 2012  Mark Charlebois
>> + */
>> +
>> +/*
>> + * EABI routines
> Does EABI specify these function names? I would think that they are
> just random libgcc (whatever that is called in clang) functions.
These specialized functions are part of the ABI for the ARM architecture 
(AEABI). They aren't random.

Memcpy and memmove *could* might be satisfied with linker magic instead. 
But memset uses the reverse parameter list.

Behan

-- 
Behan Webster
behanw at converseincode.com
