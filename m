From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 31 Jul 2011 15:51:48 +0200
Subject: [PATCH v8 0/3] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <CAHMSPgPXnDVO630P9fnogQ0XvPSrwz0MYzXfXZLJoJNRf1gifA@mail.gmail.com>
References: <1311230846-26437-1-git-send-email-b32955@freescale.com>
	<20018.43621.688990.319528@ipc1.ka-ro>
	<CAHMSPgPXnDVO630P9fnogQ0XvPSrwz0MYzXfXZLJoJNRf1gifA@mail.gmail.com>
Message-ID: <201107311551.48223.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 29, 2011 05:00:48 PM Koen Beel wrote:
> On Fri, Jul 29, 2011 at 2:41 PM, Lothar Wa?mann <LW@karo-electronics.de> 
wrote:
> > Hi,
> > 
> > Koen Beel writes:
> >> Hi,
> >> 
> >> On Fri, Jul 29, 2011 at 9:20 AM, Lothar Wa?mann <LW@karo-electronics.de> 
wrote:
> >> > Hi,
> >> > 
> >> > Koen Beel writes:
> >> >> Hi,
> >> >> 
> >> >> I have test on mx23evk board. Still see the same issues.
> >> >> 
> >> >> On Wed, Jul 27, 2011 at 3:53 AM, Huang Shijie <b32955@freescale.com> 
wrote:
> >> >> > Hi,
> >> >> > 
> >> >> > Thanks for your test.
> >> >> > 
> >> >> >> Hi,
> >> >> >> 
> >> >> >> It's not really working for me.
> >> >> >> I've applied all gpmi-nand driver patches and the dma driver
> >> >> >> patches.
> >> >> >> 
> >> >> >> I have added following kernel parameters:
> >> >> >> mtdparts=gpmi-nand:20m(boot),-(user) ubi.mtd=1 root=ubi0:rootfs0
> >> >> >> rootfstype=ubifs gpmi_debug_init
> >> >> >> 
> >> >> >> During boot I get already get DMA timeout:
> >> >> >> [    2.560000] [ start_dma_without_bch_irq : 392 ] DMA timeout,
> >> >> >> last DMA
> >> >> >> 
> >> >> >> :1
> >> >> >> 
> >> >> >> [    3.560000] [ start_dma_with_bch_irq : 427 ] bch timeout!!!
> >> >> >> ...
> >> >> >> (see log file in attach line 89)
> >> >> 
> >> >> I still see this DMA timeout when booting.
> >> >> What kernel parameters do you use? I still use same as above.
> >> > 
> >> > Do you have an SD card in the system? I'm getting the same error when
> >> > accessing an SD card. Without SD card I can use the flash without any
> >> > errors.
> >> 
> >> No SD card in the system. At least not on my mx23evk board.
> >> My real target hardware has a SDIO wifi chip.
> >> 
> >> Are you also testing on the mx23evk board? Really strange it is not
> >> reproducible here then.
> >> Anyone using mx23evk please give:
> >> - revision number of board (I have tested on rev C1)
> >> - kernel parameter used (see previous mail for mine)
> > 
> > It's getting ever more strange. I only have problems with concurrent
> > access to the flash and SD-card when I do file system based accessed
> > to the SD card.
> > A 'dd if=/dev/mmcblk0 of=/dev/null' while excessively using the flash
> > works well, while mounting the SD card and doing an 'ls' produces
> > immediate BCH DMA timeouts.
> > 
> > Perhaps someone can make anything out of that.
> 
> I have checked and the function dma_irq_callback is never called
> during my tests. This means the DMA transfer does not even works once.
> 
> Also no clue here ...

Aren't you getting some undervolt on the powerrail for example ? btw the driver 
looks a bit crappy to me, but let's believe it works ;-)

> 
> > Lothar Wa?mann
> > --
> > ___________________________________________________________
> > 
> > Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> > Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> > Gesch?ftsf?hrer: Matthias Kaussen
> > Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> > 
> > www.karo-electronics.de | info at karo-electronics.de
> > ___________________________________________________________
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
