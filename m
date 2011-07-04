From: axel.lin@gmail.com (Axel Lin)
Date: Mon, 4 Jul 2011 16:10:50 +0800
Subject: [PATCH] ARM: DMA: Add missing semicolon for the define of
	dma_alloc_area
In-Reply-To: <4E0DAB90.9080708@mvista.com>
References: <1309509472.30642.1.camel@phoenix> <4E0DAB90.9080708@mvista.com>
Message-ID: <CAF+7xW=7PM2+e1xxqfL++NGaCZjA3JoHn11vCrcK05+CVBjN7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/1 Sergei Shtylyov <sshtylyov@mvista.com>:
> Hello.
>
> On 01-07-2011 12:37, Axel Lin wrote:
>
>> I got below build error by: make at91x40_defconfig;make
>> Fix it by adding a missing semicolon for the define of dma_alloc_area.
>
>> ? CC ? ? ?arch/arm/mm/dma-mapping.o
>> arch/arm/mm/dma-mapping.c:309: warning: 'struct dma_coherent_area'
>> declared inside parameter list
>> arch/arm/mm/dma-mapping.c:309: warning: its scope is only this definition
>> or declaration, which is probably not what you want
>> arch/arm/mm/dma-mapping.c: In function '__dma_alloc':
>> arch/arm/mm/dma-mapping.c:324: error: expected ';' before '}' token
>> arch/arm/mm/dma-mapping.c: At top level:
>> arch/arm/mm/dma-mapping.c:334: warning: 'struct dma_coherent_area'
>> declared inside parameter list
>> arch/arm/mm/dma-mapping.c:374: warning: 'struct dma_coherent_area'
>> declared inside parameter list
>> make[1]: *** [arch/arm/mm/dma-mapping.o] Error 1
>> make: *** [arch/arm/mm] Error 2
>
> ? You didn't fix the warning though, so not clear why you cited them....
Because it's a copy-paste from the output of make.
I just think I should not manually edit the log.

Well, a patch to fix the warning is on the way.

Regards,
Axel
