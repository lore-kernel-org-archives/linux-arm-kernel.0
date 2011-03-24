From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 24 Mar 2011 09:33:30 +0100
Subject: [PATCH 5/7] add GPMI support for imx28
In-Reply-To: <AANLkTinjqAcCmQRdAxL+SS0LPVrRUpVBkEJmw0ZDccnq@mail.gmail.com>
References: <1300239773-4222-1-git-send-email-b32955@freescale.com>
	<1300239773-4222-6-git-send-email-b32955@freescale.com>
	<19848.39439.380861.195051@ipc1.ka-ro>
	<4D8964F4.3070104@freescale.com>
	<19850.2584.566366.251874@ipc1.ka-ro>
	<4D8AB490.30408@freescale.com>
	<19850.62451.678409.328798@ipc1.ka-ro>
	<AANLkTinjqAcCmQRdAxL+SS0LPVrRUpVBkEJmw0ZDccnq@mail.gmail.com>
Message-ID: <19851.474.327087.194875@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Jason Liu writes:
> 2011/3/24 Lothar Wa?mann <LW@karo-electronics.de>:
> > Hi,
> [...]
> >> Most of the time, the timing is really based on a safe timing setting.
> >> But in the original GPMI driver in the FREESCALE BSP, there exits some
> >> nands need to be set with their own timing setting.
> >>
> >> So I do not use the safe timing for _ALL_ the nand, and i'd better get
> >> it from the
> >> database.
> >>
> > It should be sufficient to provide timing info from platform_data in
> > special cases instead of bloating the nand id database with that
> > stuff. Platforms might need to adjust the timing because of
> > peculiarities in the HW. Thus the timing info should be provided from
> > there, not from the chip database.
> 
> No, we can't. since some boards only provide one NAND socket, customer
> can place any NAND flash chip they want. And with the NAND tech evolution, some
> NAND flash will end-of-line and customer need change another new NAND.
> As we all know that RAW NAND flash vendor does not follow the same
> rule to encode
> ID related information such as page size/oob size/block size etc. Even
> with same vendor,
> take Sumsung as example, there is not one generic rule to encode the
> id information.
> If you do NAND support with many customers, you will find that
> currenly linux NAND driver
> (nand_base.c/nand_ids.c) provide very poor support for that.
> 
That's a reason to improve that support, not to invent private fixes
for each chip driver.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
