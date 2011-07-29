From: koen.beel.barco@gmail.com (Koen Beel)
Date: Fri, 29 Jul 2011 13:48:12 +0200
Subject: [PATCH v8 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <4E32823C.3060007@freescale.com>
References: <1311230846-26437-1-git-send-email-b32955@freescale.com>
	<20110721215020.GA25344@pengutronix.de>
	<4E28EEE1.2050008@freescale.com>
	<20110722055731.GI26837@S2100-06.ap.freescale.net>
	<4E292FCF.6010608@freescale.com>
	<CAHMSPgMHrqWcJ=BThDLgQ=XyTBDCMvNS4SVjQWfk=Jf682TEig@mail.gmail.com>
	<4E2F6F90.7030207@freescale.com>
	<CAHMSPgPC4whyskfuFGeFd7WHx-=5htezWajm_rNi9Xa+03PV0A@mail.gmail.com>
	<20018.24364.787244.956361@ipc1.ka-ro>
	<CAHMSPgM5W8=mE4sRDGMMfo39fvThBo_jrdG8hyhJNQ_ceV=_pA@mail.gmail.com>
	<4E32823C.3060007@freescale.com>
Message-ID: <CAHMSPgMTf1UnMyvsSZM1in-FEAoWyS5VSdczsxfHgujGJ0DFtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 11:49 AM, Huang Shijie <b32955@freescale.com> wrote:
> ? 2011?07?29? 15:40, Koen Beel ??:
>>
>> Hi,
>>
>> On Fri, Jul 29, 2011 at 9:20 AM, Lothar Wa?mann<LW@karo-electronics.de>
>> ?wrote:
>>>
>>> Hi,
>>>
>>> Koen Beel writes:
>>>>
>>>> Hi,
>>>>
>>>> I have test on mx23evk board. Still see the same issues.
>>>>
>>>> On Wed, Jul 27, 2011 at 3:53 AM, Huang Shijie<b32955@freescale.com>
>>>> ?wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Thanks for your test.
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> It's not really working for me.
>>>>>> I've applied all gpmi-nand driver patches and the dma driver patches.
>>>>>>
>>>>>> I have added following kernel parameters:
>>>>>> mtdparts=gpmi-nand:20m(boot),-(user) ubi.mtd=1 root=ubi0:rootfs0
>>>>>> rootfstype=ubifs gpmi_debug_init
>>>>>>
>>>>>> During boot I get already get DMA timeout:
>>>>>> [ ? ?2.560000] [ start_dma_without_bch_irq : 392 ] DMA timeout, last
>>>>>> DMA
>>>>>> :1
>>>>>> [ ? ?3.560000] [ start_dma_with_bch_irq : 427 ] bch timeout!!!
>>>>>> ...
>>>>>> (see log file in attach line 89)
>>>>
>>>> I still see this DMA timeout when booting.
>>>> What kernel parameters do you use? I still use same as above.
>>>>
>>> Do you have an SD card in the system? I'm getting the same error when
>>> accessing an SD card. Without SD card I can use the flash without any
>>> errors.
>>
>> No SD card in the system. At least not on my mx23evk board.
>> My real target hardware has a SDIO wifi chip.
>
> Does it conflict with the GPMI?

Well I don't know if it conflicts. From what Lothar says I assume
there might be a conflict between gpmi and sdio.

For now I see the same problem on both the evk (no sd/sdio card) and
on my real target hardware (fixed sdio chip).

>>
>> Are you also testing on the mx23evk board? Really strange it is not
>> reproducible here then.
>> Anyone using mx23evk please give:
>
> I tested the code in mx23evk.
> After boot the kernel and login the shell, I met a problem:
> ?the flash_eraseall can not run with the log:
> "Floating point exception"
> :(
>
>
>> - revision number of board (I have tested on rev C1)
>
> Revision number is C.
>>
>> - kernel parameter used (see previous mail for mine)
>>
> "console=ttyAMA0,115200 root=/dev/mmcblk0p1 rw rootwait gpmi_debug_init"

You have a rootfs on an SD card? And gpmi is working? No conflicts on
dma or something?
Have you hard coded the mtdparts in the init code? I pass something
like "mtdparts=gpmi-nand:20m(boot),-(user)" as kernel parameter, but
you don't...

>
>
> Best Regards
> Huang Shijie
>>
>> Regards,
>> Koen
>>
>>>
>>> Lothar Wa?mann
>>> --
>>> ___________________________________________________________
>>>
>>> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
>>> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
>>> Gesch?ftsf?hrer: Matthias Kaussen
>>> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
>>>
>>> www.karo-electronics.de | info at karo-electronics.de
>>> ___________________________________________________________
>>>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
