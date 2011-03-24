From: b32955@freescale.com (Huang Shijie)
Date: Thu, 24 Mar 2011 11:07:37 +0800
Subject: [PATCH 5/7] add GPMI support for imx28
In-Reply-To: <201103231616.56375.ffainelli@freebox.fr>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>
	<4D8964F4.3070104@freescale.com>
	<19850.2584.566366.251874@ipc1.ka-ro>
	<201103231616.56375.ffainelli@freebox.fr>
Message-ID: <4D8AB579.60805@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
>>>> Hi,
>>>>
>>>> some general comments:
>>>> - Why are you not using the existing nand_ids but inventing your own
>>>>
>>>>     database?
>>> The nand_ids{} contains poor information for me.
>>> Such as :
>>> [1]The nand_ids does not have the enough information for the page
>>> size,oob size for some new NANDs.
>>>
>>>      And you can not get the information from parsing the NAND ids, such
>>>
>>> as some Micron NANDs.
>> You could use it for the standard chips where you do not need
>> additional information. That way most NAND chips could be supported
>> out of the box without having to modify the driver.
>>
>>> [2]I need the timing information of the NAND. The nand_ids DOES not have
>>> it. I have to
>>>
>>>      read the datasheet of the NAND, and add it to my database.
>> Do we really need exact timing data for each individual chip?
>> Or couldn't we live with some sane timing that works for most chips
>> and provide some means to specify a different timing via
>> platform_data?
> I suppose this is the way it should be done, but then you might some need some
> sort of NAND detection available before registering the driver. Eventually,
> the bootloader might have configured the appropriate timings already.
The bootloader does not set it.
> Have you considered using ONFI chips? They have standard timings at least.
>
The imx23/imx28 do not support ONFI chips in the DDR mode due to the 
hardware limits.
The the imx508 does support the ONFI and TOGGLE nand in the DDR mode.


Best Regards
Huang Shijie
