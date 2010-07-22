From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 22 Jul 2010 17:00:56 +0200 (CEST)
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <201007221531.58744.david.jander@protonic.nl>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221410.10087.david.jander@protonic.nl>
	<20100722125652.GL10930@sirena.org.uk>
	<201007221531.58744.david.jander@protonic.nl>
Message-ID: <alpine.LFD.2.00.1007221617370.8988@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Jul 2010, David Jander wrote:

> On Thursday 22 July 2010 02:56:52 pm Mark Brown wrote:
> > On Thu, Jul 22, 2010 at 02:10:09PM +0200, David Jander wrote:
> > > IMO, if a bootloader is broken (in any way), it needs replacing. Be it
> > > with another bootloader or directly with the kernel.
> > 
> > If you don't have JTAG access (either due to device limitations or due
> > to lack of data from the vendor of a reference platform you're using)
> > replacing a bootloader can be rather more stressful than it's worth.
> 
> I agree, but I simply can't believe ARM platform designers all do such a bad 
> job at firmware (=bootloader) development in general, which is in sharp 
> contrast to what I have learned from previous PowerPC developments.

Well, this obviously didn't impair the success of the ARM architecture, 
nor did crappy BIOS has impaired the x86 architecture.  Becoming 
"mainstream" as the ARM architecture is becoming is always bound to 
create crap on the edges, such as poorly revised bootloader code.  And 
just as on X86, it is often better to simply not rely too much on the 
bootloader.  Mistakes and bugs will always happen in both the kernel and 
the bootloader.  But it is much more easier and efficient resource wise 
to fix a config bug in the kernel and updating it on the affected kernel 
than it is for fixing the same bug in the bootloader and updating the 
bootloader there.

> How can you assume that kernel-developers know how to correcly set-up the slew 
> rate and drive-strength of an I/O-pin for a given platform if the manufacturer 
> itself didn't do it nor document it!??

You can't.  But the kernel can be fixed while in many cases the 
bootloader practically can't.

> Even if it works with one guessed setting, there is a potential EMC impact 
> that needs to be taken care of.

What I've implemented so far is the ability to either set some 
parameters, or keep the existing ones, but not require for the kernel to 
have to setup everything up.  So if you don't know the right value for a 
setting as a kernel developer then you may just elect to leave it alone 
and hope that the bootloader has set it right.

> There are important hardware-design decisions after each of those settings! If 
> we continue this amateuristic approach, ARM-linux platforms will never get 
> taken seriously in more demanding environments. This really needs to change.

You are more than welcome to change this state of affairs.  And if you 
truly succeed where we all failed so far then it will only be a matter 
of removing the made redundant and useless setup code in the kernel.


Nicolas
