From: b32955@freescale.com (Huang Shijie)
Date: Thu, 17 Mar 2011 10:19:15 +0800
Subject: [PATCH 1/7] ARM: add GPMI support for imx23/imx28
In-Reply-To: <19840.43943.592336.854865@ipc1.ka-ro>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>	<1300239773-4222-2-git-send-email-b32955@freescale.com>	<19840.36163.967469.53941@ipc1.ka-ro>	<4D809453.4090603@freescale.com>
	<19840.43943.592336.854865@ipc1.ka-ro>
Message-ID: <4D816FA3.2080202@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:

> Huang Shijie writes:
>> Hi Lothar:
>>> Hi,
>>>
>>> All in all I do not like this driver in any way. I already vomitted
>>> over it, when I saw it in the Freescale BSP.
>> :)  I have already removed a lot of code.
>>
>>> There is no need for the multiple layers of abstraction that are
>>> papered over the MTD layer.
>> I think this is good. Make the code clear.
>>
> I'll comment when the remaining patch has got through.
>
thanks a lot .


>>> There is no need for spilling the driver over a dozen files.
>> I can merge some files into one. thanks.
>>
> IMO all the source code could be kept in one file (except for the
> include files of course) and the gpmi-nfc subdirectory removed.
I really can merge some files, but IMHO, it's not a good solution to 
keep all in one file.

The reasons are :
[1] The GPMI support the NAND boot mode,but the imx23 and imx28 is a 
little different in
the NAND boot procedure due the different firmwares in the chips. If I 
merge the rom-imx23.c
rom-imx28.c to one file, the code will very mess. ugly enough!

[2]The GPMI driver is just a mini version against the version in the 
FREESCALE BSP.
The original GPMI driver also support the IMX508 which is different from 
the imx23 and imx28.
The imx508 supports the ONFI NAND and TOGGLE NAND which are DDR mode 
NAND.So the implement of
ECC read_page/write_page is much different from the IMX23/IMX28. Because 
I want to support the
IMX508 in future, this is why the hal-imx23.c and hal-imx28.c share most 
the same code,but i still
remain them in separate, the reason is simple : I will add a 
hal-imx508.c in future.

[3]The GPMI driver is a little complicated. The GPMI controller needs 
other two hardware module to
work :the BCH module, and the DMA mode.
      Yes, i can merge the DMA code into other files, but the BCH module 
should occupy a separate file to
make the logic clear.

[4] If i packet all the code in one, the gentlemen of MTD mailist, such 
as David Woodhouse, Artem Bityutskiy ,
will kill me, :).  what's more the big boy even can not be emailed to 
arm-kernel maillist.


> I've been working on this too, but had to abandone it for other tasks
> several times. :(
>
I really apreciate for your review and comments. I just want to make the 
drive tidy and grace.

Please point out the ugly part that you regards in free.

I am very glad you had ever tried to work on this. :)


Best Regards
Huang Shijie
