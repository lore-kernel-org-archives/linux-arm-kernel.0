From: david.jander@protonic.nl (David Jander)
Date: Thu, 22 Jul 2010 15:31:58 +0200
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <20100722125652.GL10930@sirena.org.uk>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221410.10087.david.jander@protonic.nl>
	<20100722125652.GL10930@sirena.org.uk>
Message-ID: <201007221531.58744.david.jander@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 July 2010 02:56:52 pm Mark Brown wrote:
> On Thu, Jul 22, 2010 at 02:10:09PM +0200, David Jander wrote:
> > IMO, if a bootloader is broken (in any way), it needs replacing. Be it
> > with another bootloader or directly with the kernel.
> 
> If you don't have JTAG access (either due to device limitations or due
> to lack of data from the vendor of a reference platform you're using)
> replacing a bootloader can be rather more stressful than it's worth.

I agree, but I simply can't believe ARM platform designers all do such a bad 
job at firmware (=bootloader) development in general, which is in sharp 
contrast to what I have learned from previous PowerPC developments.

Maybe the difference is in the market: PowerPC is more geared towards an 
industrial embedded market (high demand of robustness and reliability), while 
ARM comes from a pure consumer market, and is just lately making inroads into 
industrial applications.

> > That sounds a lot "saner" to me than having two asynchronous and
> > different copies of setup-code, which could be a potential nightmare,
> > besides not being really maintainable.
> 
> Well, from the point of view of using systems like this all you need the
> bootloader to do is to set the system up enough to load the kernel and
> start it running.  You don't need it to understand anything else about
> the rest of the system, which means you're less reliant on the quality
> of the bootloader.

How can you assume that kernel-developers know how to correcly set-up the slew 
rate and drive-strength of an I/O-pin for a given platform if the manufacturer 
itself didn't do it nor document it!??
Even if it works with one guessed setting, there is a potential EMC impact 
that needs to be taken care of.

There are important hardware-design decisions after each of those settings! If 
we continue this amateuristic approach, ARM-linux platforms will never get 
taken seriously in more demanding environments. This really needs to change.

Best regards,

-- 
David Jander
Protonic Holland.
