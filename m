From: mnalajal@codeaurora.org (Murali Nalajala)
Date: Sat, 16 Apr 2011 15:45:00 +0530
Subject: [PATCH 2/2] mtd: msm_nand: Add initial msm nand driver support.
In-Reply-To: <1302942712.2308.3.camel@koala>
References: <1298940450-27365-1-git-send-email-mnalajal@codeaurora.org>	
	<1298940450-27365-2-git-send-email-mnalajal@codeaurora.org>	
	<1302861097.3220.12.camel@localhost>
	<4DA85B24.50807@codeaurora.org>	
	<1302942029.2308.1.camel@koala> <1302942712.2308.3.camel@koala>
Message-ID: <4DA96C24.707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/16/2011 2:01 PM, Artem Bityutskiy wrote:
> On Sat, 2011-04-16 at 11:20 +0300, Artem Bityutskiy wrote:
>>>> +#define MSM_NAND_REG(off) (msm_nand_phys + (off))
>>>> +
>>>> +#define MSM_NAND_FLASH_CMD            MSM_NAND_REG(0x0000)
>>>> +#define MSM_NAND_ADDR0                MSM_NAND_REG(0x0004)
>>>>
>>>> Could you please make the macros to take the "struct msm_nand_chip
>>>> *chip" argument instead, and store the pase address there. Do not hide
>>>> the fact that those macros are actually functions, not constant - this
>>>> is error prone.
>>>>
>>>> Besides, I'm do not know your HW, but if you have several controllers
>>>> with various base addresses - your driver won't work.
>>>
>>> you are correct, we have multiple controllers, which breaks this logic
>>> in future.
>>
>> So then make your macros to accept the base address as an argument
>> instead please.
>
> Or better make macros to be constants, and always use something like
> base + MSM_NAND_FLASH_CMD - this is the standard approach.

Here all the registers expands to 'base + register offset'.
In the code we are directly using the macro names (these are register 
names on my controller) i.e. MSM_NAND_FLASH_CMD & MSM_NAND_ADDR0 without 
thinking of what the controller base is and what controller it is.

Currently, this code we have targeted for the single NAND controller 
solution for some of the MSM's. There are other targets which uses 
multiple NAND controllers which we haven't done much work yet to submit 
those patches.

Thanks,
Murali N

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
