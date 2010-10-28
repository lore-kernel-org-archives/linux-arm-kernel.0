From: nils.faerber@kernelconcepts.de (Nils Faerber)
Date: Thu, 28 Oct 2010 21:33:13 +0200
Subject: New Kirkwood board support
In-Reply-To: <20101028190133.GC31158@pengutronix.de>
References: <4CC9C245.3030906@kernelconcepts.de>
	<20101028190133.GC31158@pengutronix.de>
Message-ID: <4CC9CFF9.3070808@kernelconcepts.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.10.2010 21:01, schrieb Uwe Kleine-K?nig:
> On Thu, Oct 28, 2010 at 08:34:45PM +0200, Nils Faerber wrote:
>>  arch/arm/configs/tk71_defconfig     | 1700 +++++++++++++++++++++++++++++++++++
> I'm sure we're not taking new defconfigs now.  Can you add your machine
> to an existing defconfig?  Moreover it's not reduced.  You need to do at

Hmm... I have to look at the others. Probably a good idea.

> least:
> 	make tk71_defconfig
> 	make savedefconfig
> 	mv defconfig arch/arm/configs/tk71_defconfig

OK, thanks, will check that out!

>> +	/* eth1 */
>> +	if (gpio_request(28, "PHY2 reset") != 0 ||
>> +		gpio_direction_input(28) != 0) // high-z
> I don't know if it's usually in mach-kirkwood to write it this way, but
> I think it can be done in a more readable way.

Most importantly I juts saw a remaining "//" comment - oops!

But how more readable should I do that? The pin is assigned to the gpio
system (which is IMHO a good idea) and those line should make it high
impedance. This has nothing much to do with kirkwood I think.

>> +		printk(KERN_ERR "can't deassert GPIO 28 (PHY2 reset)\n");
> pr_err maybe?

Well - sure, could take that too, OK.

>> +MACHINE_START(TK71, "TK71 Kirkwood based Q7 formfactor board")
>> +	/* Maintainer: Nils Faerber <nils.faerber@kernelconcepts.de> */
>> +	.phys_io	= KIRKWOOD_REGS_PHYS_BASE,
>> +	.io_pg_offst	= ((KIRKWOOD_REGS_VIRT_BASE) >> 18) & 0xfffc,
> These fields don't exist anymore.

Oh really? Which more exactly? I miss to see the difference with other
boards in the mach-kirkwood/ subdir.

Thanks for the hints!

> Best regards
> Uwe
Cheers
  nils

-- 
kernel concepts GbR      Tel: +49-271-771091-12
Sieghuetter Hauptweg 48  Fax: +49-271-771091-19
D-57072 Siegen           Mob: +49-176-21024535
http://www.kernelconcepts.de
