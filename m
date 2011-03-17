From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 17 Mar 2011 11:36:22 +0100
Subject: [PATCH 1/7] ARM: add GPMI support for imx23/imx28
In-Reply-To: <4D816FA3.2080202@freescale.com>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>
	<1300239773-4222-2-git-send-email-b32955@freescale.com>
	<19840.36163.967469.53941@ipc1.ka-ro>
	<4D809453.4090603@freescale.com>
	<19840.43943.592336.854865@ipc1.ka-ro>
	<4D816FA3.2080202@freescale.com>
Message-ID: <19841.58406.756435.967812@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> Hi:
> 
> > Huang Shijie writes:
> >> Hi Lothar:
> >>> Hi,
> >>>
> >>> All in all I do not like this driver in any way. I already vomitted
> >>> over it, when I saw it in the Freescale BSP.
> >> :)  I have already removed a lot of code.
> >>
> >>> There is no need for the multiple layers of abstraction that are
> >>> papered over the MTD layer.
> >> I think this is good. Make the code clear.
> >>
> > I'll comment when the remaining patch has got through.
> >
> thanks a lot .
> 
> 
> >>> There is no need for spilling the driver over a dozen files.
> >> I can merge some files into one. thanks.
> >>
> > IMO all the source code could be kept in one file (except for the
> > include files of course) and the gpmi-nfc subdirectory removed.
> I really can merge some files, but IMHO, it's not a good solution to 
> keep all in one file.
> 
> The reasons are :
> [1] The GPMI support the NAND boot mode,but the imx23 and imx28 is a 
> little different in
> the NAND boot procedure due the different firmwares in the chips. If I 
> merge the rom-imx23.c
> rom-imx28.c to one file, the code will very mess. ugly enough!
> 
You can use platform_ids to differentiate between the versions and
have separate functions for imx23 and imx28 where appropriate and
select between those depending on the platform_id.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
