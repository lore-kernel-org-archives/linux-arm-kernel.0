From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 18 Feb 2011 00:45:22 +0000
Subject: [PATCH V3 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <cb015a68-c46f-400b-97ba-e1bf32e8dc2c@VA3EHSMHS019.ehs.local>
References: <1297872716-13353-1-git-send-email-john.linn@xilinx.com>
	<1297872716-13353-2-git-send-email-john.linn@xilinx.com>
	<1297872716-13353-3-git-send-email-john.linn@xilinx.com>
	<e58673f5-2881-4820-b5cd-99e8ef294ed5@VA3EHSMHS024.ehs.local>
	<20110217100126.GD22961@pulham.picochip.com>
	<cb015a68-c46f-400b-97ba-e1bf32e8dc2c@VA3EHSMHS019.ehs.local>
Message-ID: <20110218004522.GA27462@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 05:37:47PM -0700, John Linn wrote:
> > > +static inline void arch_reset(char mode, const char *cmd)
> > > +{
> > > +	/* Add architecture specific reset processing here */
> > 
> > I think you can add cpu_reset(0) in here to try a soft reset by
> jumping
> > to the reset vector.  This should give you some reset functionality.
> 
> Hi Jamie,
> 
> How strongly do you feel that this has to be in on this initial patch
> set?
> 
> There will be many more coming later and I'd like to postpone that one
> as it's really additional
> functionality vs a bug (to me anyway).

I don't have a strong opinion on it.  If you leave it as it is so that 
arch_reset() will return then the generic ARM code will issue a printk 
to tell the user that it failed then drop into an infinite loop so it 
should be obvious that reset isn't implemented!

If reset is nontrivial then you're probably right to leave it out of 
this patch and put it into another later on.

Jamie
