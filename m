From: redhatter@gentoo.org (Stuart Longland)
Date: Tue, 18 May 2010 19:44:25 +1000
Subject: i.MX27 Clock sources
In-Reply-To: <19442.22529.98355.153495@ipc1.ka-ro>
References: <20100518075109.GC1749@www.longlandclan.yi.org>
	<19442.22529.98355.153495@ipc1.ka-ro>
Message-ID: <20100518094420.GA11009@www.longlandclan.yi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 11:04:01AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> > 	Ideally I'd like to adjust MPLL/SPLL and/or the SSI clocks so
> > that the clock rate is some multiple of the I?S bit rate.  So far I can
> > get it close; but not close enough.  Does anyone have any pointers as to
> > where I can look in the Linux kernel for this information?
> > 
> Can't you use the codec in master mode, instead of fiddling with the
> CPU clocks?

I think we will do this -- but the issue is still faced since the CODEC
derives its clocks from a clock supplied on a separate SSI bus.  (This
was done to avoid the need of a separate oscillator.)

I haven't succeeded in getting the CODEC's onboard PLL to generate the
required clocks either -- I'll be doing some further investigation on
this tomorrow.  However, the other way of achieving this is to tweak the
CPU to run its clocks at the required rate... and this is the other
possibility I'm exploring.

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
