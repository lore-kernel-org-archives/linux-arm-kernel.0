From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Jun 2010 20:12:08 +0100
Subject: [PATCH 3/4] pxa2xx/cpufreq: Fix PCMCIA frequency scaling
In-Reply-To: <201006242051.27790.marek.vasut@gmail.com>
References: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
	<1276840135-5982-3-git-send-email-marek.vasut@gmail.com>
	<87mxulabaw.fsf@free.fr> <201006242051.27790.marek.vasut@gmail.com>
Message-ID: <20100624191208.GB7974@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 08:51:27PM +0200, Marek Vasut wrote:
> Dne St 23. ?ervna 2010 19:49:59 Robert Jarzmik napsal(a):
> > Marek Vasut <marek.vasut@gmail.com> writes:
> > > The MCxx values must be based off memory clock, not CPU core clock.
> > > 
> > > This also fixes the bug where on some machines the LCD went crazy while
> > > using PCMCIA.
> > 
> > That looks correct to me.
> > 
> > Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > 
> > Cheers.
> > 
> > --
> > Robert
> 
> Actually lemme rethink this ... it might still be incorrect.

As Nicolas was the one who originally wrote that code, while he was
working for Montavista and interacting with Intel, I'd be surprised
if he didn't try finding out what the right answer is to that fixme.

I suspect as the fixme remained that there was no clear answer.

Nicolas, can you shed any light on this:

static int
pxa2xx_pcmcia_frequency_change(struct soc_pcmcia_socket *skt,
                               unsigned long val,
                               struct cpufreq_freqs *freqs)
{
#warning "it's not clear if this is right since the core CPU (N) clock has no effect on the memory (L) clock"
