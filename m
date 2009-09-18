From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Fri, 18 Sep 2009 17:52:51 +0300
Subject: [PATCH 1/2] ARM: Pass IFSR register to do_PrefetchAbort()
In-Reply-To: <cc557aab0909180445o33b6792ewf62a4f5e7589547@mail.gmail.com>
References: <f00f1348d91d2403ea0f1c5f05b3ac713664fe7b.1253281256.git.kirill@shutemov.name>	
	<alpine.DEB.1.00.0909181422370.11448@ak-desktop>
	<cc557aab0909180445o33b6792ewf62a4f5e7589547@mail.gmail.com>
Message-ID: <4AB39EC3.4050202@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Kirill A. Shutemov wrote:
>>  #ifdef CONFIG_CPU_PABRT_NOIFAR
>> -# ifdef CPU_PABORT_HANDLER
>> +# ifdef CPU_PABORT_HANDLER_IFAR
>>  #  define MULTI_PABORT 1
>>  # else
>> -#  define CPU_PABORT_HANDLER(reg, insn)        mov reg, insn
>> +#  define CPU_PABORT_HANDLER_IFAR(reg, insn)   mov reg, insn
>> +#  define CPU_PABORT_HANDLER_IFSR(reg)         mrc p15, 0, reg, cr5, cr0, 1
> 
> It's incorrect. We have IFSR only on ARMv7.

It seems my assumption on the availability of that register was wrong, 
but I think it's available at least on ARMv6, and also that IFAR can be 
optional...

A.
