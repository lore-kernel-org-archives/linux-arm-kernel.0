From: b32955@freescale.com (Huang Shijie)
Date: Thu, 15 Sep 2011 17:20:11 +0800
Subject: [PATCH v12 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <20081.49563.934890.760378@ipc1.ka-ro>
References: <1315450031-6371-1-git-send-email-b32955@freescale.com>	<20081.44941.12535.496764@ipc1.ka-ro>	<4E71B741.7010907@freescale.com>
	<20081.49563.934890.760378@ipc1.ka-ro>
Message-ID: <4E71C34B.3050308@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> Hi,
>
> Huang Shijie writes:
>> Hi,
>>    add more CC.
>>> Hi,
>>>
>>> Huang Shijie writes:
>>>> The patch set is based on Artem's tree:
>>>> 	http://git.infradead.org/users/dedekind/l2-mtd-2.6.git
>>>>
>>>> The general-purpose media interface(GPMI) controller is a flexible interface
>>>> to up to several NAND flashs.
>>>>
>>>> The Bose Ray-Choudhury Hocquenghem(BCH) module is a hardware ECC accelerator.
>>>>
>>>> With the help of BCH, the GPMI controller can choose to do the hardware ECC or
>>>> not.
>>>>
>>>> This driver is a _pure_ MTD NAND controller driver now.
>>>>
>>>>
>>>> The driver depends on another GPMI-NAND device patch set, you can find them at :
>>>> 	[1] http://marc.info/?l=linux-arm-kernel&m=131416901319573&w=2
>>>> 	[2] http://marc.info/?l=linux-arm-kernel&m=131416912319668&w=2
>>>> 	[3] http://marc.info/?l=linux-arm-kernel&m=131416891119504&w=2
>>>> 	[4] http://marc.info/?l=linux-arm-kernel&m=131416896219539&w=2
>>>>
>>>> Test environment:
>>>> 	Using imx23 and imx28 boards for test.
>>>>
>>>> 	imx23 :
>>>> 	console=ttyAMA0,115200 mtdparts=gpmi-nfc:20m(boot),-(user)
>>>> 	Tested by USB boot and NAND boot.
>>>>
>>>>           imx28 :
>>>> 	#console=ttyAMA0,115200 root=/dev/mmcblk0p3 rw rootwait
>>>> 	Tested by SD card boot mode.
>>>>
>>> How did you perform your tests?
>>>
>>> I tried this driver on our TX28 board with the result that with
>> The nand conflicats with SD card1. You will get the DMA timeout if you
>> use it.
>> Do you use sd card0 or sd card1?
>>
> I'm using the SSP0 port.
>
ok.
>> BTW:I tested the gpmi driver with SD card0. It works fine.
>>
> What exactly did you do in your test?
I tested it with bonnie++.
> Can you try the concurrent 'dd' commands that I used?
not yet.

I will test it right now.

Huang Shijie
>
> Lothar Wa?mann
