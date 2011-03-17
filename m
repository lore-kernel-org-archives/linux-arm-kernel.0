From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Thu, 17 Mar 2011 23:00:22 +0100
Subject: [PATCH 4/9] lpc2k: generic time and clockevents
In-Reply-To: <20110317213824.GB2927@pulham.picochip.com>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-5-git-send-email-ithamar.adema@team-embedded.nl>
	<20110317213824.GB2927@pulham.picochip.com>
Message-ID: <1300399222.2138.96.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-17 at 21:38 +0000, Jamie Iles wrote:
> One pedantic nitpick, but otherwise looks nice to me.

Thanks for reviewing, and pedantic nitpicks are always welcome ;)

> On Thu, Mar 17, 2011 at 04:54:19PM +0100, Ithamar R. Adema wrote:
[....]
> > +static struct clock_event_device lpc2k_clkevt = {
> > +	.name		= "lpc2k_clkevt",
> > +	.features	= CLOCK_EVT_FEAT_ONESHOT,
> > +	.shift		= 32,
> 
> You shouldn't need to specify a shift if you use 
> clockevents_calc_mult_shift() and let the core code calculate mult and 
> shift for you.

Good point, I should use that. Will include this in the next version of
these patches!

Regards,

Ithamar.
