From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 16:44:11 +0100
Subject: [PATCH 01/17] ARM: pxa/raumfeld: add basic structure for devices
In-Reply-To: <4B0D4CA8.4020107@compulab.co.il>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-2-git-send-email-daniel@caiaq.de>
	<4B0D4CA8.4020107@compulab.co.il>
Message-ID: <20091125154411.GN29442@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wed, Nov 25, 2009 at 05:26:32PM +0200, Mike Rapoport wrote:
> Below are my comments to the patches. Some of the comments apply to several
> patches, but I'm too lazy to copy them into relevant threads :)

Ok, I squashed most of the commits together for the next round so make
hat easier :)

> Daniel Mack wrote:
> > +static void __init raumfeld_common_init(void)
> > +{
> > +	enable_irq_wake(IRQ_WAKEUP0);
> > +	pxa_set_ffuart_info(NULL);
> > +
> > +	gpio_request(mfp_to_gpio(GPIO_W2W_RESET), "Wi2Wi reset");
> 
> gpio_request may fail, thought it's unlikely to happen. Anyway, adding check for
> it's return value seems to be a good practice.

Ok, I put BUG_ON() around them. I see no reason to care for proper error
handling as this is not a driver. If any of those functions fail in the
low-level code, there is something seriously broken.

> > +static void __init raumfeld_speaker_init(void)
> > +{
> > +	raumfeld_common_init();
> > +}
> 
> I failed to follow what peripherals are common to what boards, but after
> applying all the patches it seems that all three _init functions are really
> similar. Have you considered having one _init function for all three machines
> and calling machine-specific init based on machine_is_X?

Yes, I did consider that. But eventually, they are a) all not big and b)
too different. Doing the way you suggest make it look more messy. Have a
look at the second round and tell me if you stick to your opponion :)

Thanks for your input,
Daniel
