From: junxiao.bi@windriver.com (Bi Junxiao)
Date: Tue, 22 Nov 2011 13:27:36 +0800
Subject: [PATCH 6/6] ARM: support kernel modules in BE8 mode
In-Reply-To: <alpine.LFD.2.02.1111212310520.17904@xanadu.home>
References: <1321322785-2981-1-git-send-email-junxiao.bi@windriver.com>
 <1321322785-2981-6-git-send-email-junxiao.bi@windriver.com>
 <alpine.LFD.2.02.1111211427400.17904@xanadu.home>
 <4ECAFBA0.2030001@windriver.com>
 <alpine.LFD.2.02.1111212310520.17904@xanadu.home>
Message-ID: <4ECB32C8.4090300@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

on 11/22/2011 12:17 PM Nicolas Pitre wrote:
> On Tue, 22 Nov 2011, Bi Junxiao wrote:
>
>    
>> on 11/22/2011 03:29 AM Nicolas Pitre wrote:
>>      
>>> On Tue, 15 Nov 2011, Junxiao Bi wrote:
>>>
>>>
>>>        
>>>> From: Stanley.Miao<stanley.miao@windriver.com>
>>>>
>>>> In BE8 mode, data must be manipulated in big endian format while
>>>> text must be little endian. Therefore, when relocating the text
>>>> section of module in BE8 mode, we must convert the location offset
>>>> of the text to big endian from the native little endian. After
>>>> the relocation is complete, the location offset value is re-written
>>>> as little endian.
>>>>
>>>> Since only BE8 mode has such special requirement while other big endian
>>>> mode not, cpu_to_le32 and le32_to_cpu can not be used to relocate the
>>>> text. We introduce write_instr* and read_instr* to do it.
>>>>          
> [...]
>    
>>> If only module.c requires this, please move those definitions there.
>>>
>>>        
>> Not only modules, all components that needs to read and write text segment
>> like kprobes also needs this. As it is special to arm be8, how about define it
>> in arch/arm/include/asm/swab.h?
>>      
> There is a patch series proposed by Leif Lindholm adding generic ARM
> instruction condition code check that creates an opcode.h file.  That
> would be an ideal location for opcode accessor definitions.
>    
Thank you for the guide. I will put there in V2.
>
> Nicolas
>
>    
