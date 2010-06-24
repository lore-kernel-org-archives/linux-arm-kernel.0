From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 24 Jun 2010 21:33:07 +0200
Subject: [PATCH 3/4] pxa2xx/cpufreq: Fix PCMCIA frequency scaling
In-Reply-To: <20100624191208.GB7974@n2100.arm.linux.org.uk>
References: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
	<201006242051.27790.marek.vasut@gmail.com>
	<20100624191208.GB7974@n2100.arm.linux.org.uk>
Message-ID: <201006242133.07899.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 24. ?ervna 2010 21:12:08 Russell King - ARM Linux napsal(a):
> On Thu, Jun 24, 2010 at 08:51:27PM +0200, Marek Vasut wrote:
> > Dne St 23. ?ervna 2010 19:49:59 Robert Jarzmik napsal(a):
> > > Marek Vasut <marek.vasut@gmail.com> writes:
> > > > The MCxx values must be based off memory clock, not CPU core clock.
> > > > 
> > > > This also fixes the bug where on some machines the LCD went crazy
> > > > while using PCMCIA.
> > > 
> > > That looks correct to me.
> > > 
> > > Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > > 
> > > Cheers.
> > > 
> > > --
> > > Robert
> > 
> > Actually lemme rethink this ... it might still be incorrect.

Rethought ... well I think there's no problem with this. Anyway, thanks for 
CCing Nico.

This patch fixed an issue on zaurus so I believe it's ok.
> 
> As Nicolas was the one who originally wrote that code, while he was
> working for Montavista and interacting with Intel, I'd be surprised
> if he didn't try finding out what the right answer is to that fixme.
> 
> I suspect as the fixme remained that there was no clear answer.

Well if you look into some schematics, you see the pxa pcmcia is connected to 
the memory bus ... as other peripherals.

> 
> Nicolas, can you shed any light on this:
> 
> static int
> pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
>                                unsigned long val,
>                                struct cpufreq_freqs *freqs)
> {
> #warning "it's not clear if this is right since the core CPU (N) clock has
> no effect on the memory (L) clock"

Cheers

PS. Russell ... feel like doing some politics again? ;-) (take it as a joke 
please)
