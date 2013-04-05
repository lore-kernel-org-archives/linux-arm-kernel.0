From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 5 Apr 2013 18:26:17 -0300
Subject: mvebu: Device bus driver resurrection
In-Reply-To: <20130326164505.GB30255@obsidianresearch.com>
References: <20130326124337.GD2454@localhost>
 <20130326164505.GB30255@obsidianresearch.com>
Message-ID: <20130405212616.GB2290@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Mar 26, 2013 at 10:45:05AM -0600, Jason Gunthorpe wrote:
> On Tue, Mar 26, 2013 at 09:43:38AM -0300, Ezequiel Garcia wrote:
> > Hello everyone,
> > 
> > Now that we've all agreed on a mvebu mbus driver (or a first version of it)
> > I'd like to resurrect the Device Bus driver.
> > 
> > As far as I can remember, the last things said about this driver were:
> > 
> >   * The timing parameters should be in {nano,pico,etc} seconds,
> >     instead of ticks.
> 
> Yes, and I saw Rob Herring note that the DT parameters in cases like
> that should end in -ps
>  
> >   * Although not everyone agreed, this driver was a good thing to have
> >     so we no longer depend on the bootloader setting these parameters.
> 
> Please make the timing parameters mandatory, not optional. If boot
> loader set timing is going to be used then this driver should not be
> involved. Otherwise the timing should be fully specified and no values
> from the bootloader should be retained.
> 
> >   * The address decoding windows should *not* be setup by this driver,
> >     but rather be described in the device tree itself.
> 
> I'm going to suggest you send out a quick DT sample for what you are
> thinking, that might save lots of effort?
> 

I've just sent a v2 for the Device Bus work, which takes care of all
your comments, except for the quick DT sample.
I hope it looks better now!

I'm not sure how close we are to an agreed mbus DTS binding, but I hope
the Device Bus can still get merged as it is, so we can have NOR support
as early as possible. Since the proposed DTS is really minimal, I expect
it to be innocuous.

If at all possible, could you take a look at it and tell me what do you think?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
