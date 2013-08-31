From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 31 Aug 2013 13:55:19 +0200
Subject: [PATCH 2/2] ARM: Dove: Add the audio device to the Cubox DT
In-Reply-To: <20130831112430.GD6617@n2100.arm.linux.org.uk>
References: <20130828113521.35c53365@armhf> <521DCD80.9010105@gmail.com>
 <20130831125128.0e3a23c7@armhf>
 <20130831112430.GD6617@n2100.arm.linux.org.uk>
Message-ID: <20130831135519.6ab0e163@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 31 Aug 2013 12:24:31 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> > According to the Dove specification, the audio controller works with
> > the samples rates 44.1, 48 and 96 kHz, so, I don't see the usage of the
> > external clock, except when using the two audio controllers with
> > different sample rates.
	[snip]
> > But, BTW, as the kirkwood-i2 driver is written, this last case does not
> > work: for 44.1, 48 and 96 kHz, the external clock is never used and
> > there is only one DCO.  
> 
> This doesn't make sense.  "this last case" - what "case" are you referring
> to?  "there is only one DCO" ?  Yes, there is only one DCO, what is its
> relevance to the statement you're making?  And yes, in mainline we
> currently use the DCO for the standard 44.1, 48 and 96kHz sample rates.
> That's fine.  Confused.

Sorry, it was clear in my head :)

The last case was "when using the two audio controllers with different
sample rates" (I should have added "in the set [44.1, 48, 96 kHz]").
Then, with or without the availability of external clocks, both
controllers will set the unique DCO to two different rates.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
