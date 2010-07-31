From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 31 Jul 2010 09:33:05 +0200
Subject: [PATCH] PXA: Colibri320: Add M41T00 RTC support
In-Reply-To: <201007310926.03292.pieterg@gmx.com>
References: <1280543453-28237-1-git-send-email-marek.vasut@gmail.com>
	<201007310926.03292.pieterg@gmx.com>
Message-ID: <201007310933.05611.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 31. ?ervence 2010 09:26:03 pieterg napsal(a):
> On Saturday 31 July 2010 04:30:53 Marek Vasut wrote:
> > +#if defined(CONFIG_RTC_DRV_DS1307) ||
> > defined(CONFIG_RTC_DRV_DS1307_MODULE)
> > +static mfp_cfg_t colibri_pxa320_i2c_pin_config[] __initdata = {
> > +	GPIO32_I2C_SCL,
> > +	GPIO33_I2C_SDA,
> > +};
> 
> Should the i2c pins really depend on the DS1307 config?
> On my board, I use a different rtc. So I do need the I2C pins to be
> configured, but I don't need the DS1307.
> 
> A few weeks ago I submitted
> 
> [PATCH 4/5] colibri-pxa3xx: add i2c support
> 
> which initializes the i2c gpio's, depending on CONFIG_I2C ||
> CONFIG_I2C_MODULE
> 
> (but the patch was rejected, argueing that people might want to use
> different gpio's for i2c)
> 
> Rgds, Pieter

Well I'd like to rework the colibri pxa3xx stuff later, but I'll have to discuss 
it with Dan. I believe reworking it the same way as pxa270 colibri would be nice 
(and it'd solve your problem too as you use custom board I think?).

Actually, there is one thing that puzzles me. Eric/Dan, shall I stick all the 
MFP configs into one (or two, one for board and once for cpu card) array or keep 
it split in multiple smaller arrays for each device? I think putting it all in 
one place would be more readable.

Cheers
