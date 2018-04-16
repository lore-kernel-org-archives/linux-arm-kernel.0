From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 16 Apr 2018 19:48:31 -0400
Subject: [PATCH 1/2] parisc: use the asm-generic version for writeX()
In-Reply-To: <1152a7d4-a8f4-ae68-2737-067fa05409cd@codeaurora.org>
References: <1523916078-23049-1-git-send-email-okaya@codeaurora.org>
 <a727e74f-610c-4722-76e9-c1aca2f9e9bd@bell.net>
 <a7b59f43-cea5-0ead-f528-61899570e353@codeaurora.org>
 <7a9d139e-978b-750d-1bac-8b27e934f781@bell.net>
 <1152a7d4-a8f4-ae68-2737-067fa05409cd@codeaurora.org>
Message-ID: <4eea352e-07f0-3a99-c9bd-57e117288778@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/2018 7:44 PM, Sinan Kaya wrote:
>> John David Anglin? dave.anglin at bell.net
>>
>>
>> io.log
>>
>>
>>   CC      arch/parisc/kernel/asm-offsets.s
>> In file included from ./arch/parisc/include/asm/io.h:262:0,
>>                  from ./include/linux/io.h:25,
>>                  from ./include/linux/irq.h:25,
>>                  from ./arch/parisc/include/asm/hardirq.h:13,
>>                  from ./include/linux/hardirq.h:9,
>>                  from arch/parisc/kernel/asm-offsets.c:34:
>> ./include/asm-generic/io.h:37:21: error: redefinition of '__raw_readb'
>>  #define __raw_readb __raw_readb
>>                      ^
> This one is easy to fix:
> 
> https://elixir.bootlin.com/linux/latest/source/arch/parisc/include/asm/io.h#L146
> 
> Remove 146..179.

I'll try to get a hold of a cross compiler and re-test. The above is a hack.
I need to do a better job on this.

Thanks for the help. I'll post V2 when it is ready.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
