From: joshc@codeaurora.org (Josh Cartwright)
Date: Mon, 9 Sep 2013 11:56:04 -0500
Subject: [PATCH RFC v2 2/5] spmi: Linux driver framework for SPMI
In-Reply-To: <20130909155224.GQ29403@sirena.org.uk>
References: <cover.1377202730.git.joshc@codeaurora.org>
 <46db5901fe4d04d09cee8fd81ea1c62068ee9503.1377202730.git.joshc@codeaurora.org>
 <20130822231054.GA31973@kroah.com>
 <20130823160625.GP4035@joshc.qualcomm.com>
 <20130909155224.GQ29403@sirena.org.uk>
Message-ID: <20130909165604.GM808@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Mark-

Thanks for the comments.

On Mon, Sep 09, 2013 at 04:52:24PM +0100, Mark Brown wrote:
> On Fri, Aug 23, 2013 at 11:06:25AM -0500, Josh Cartwright wrote:
> > On Thu, Aug 22, 2013 at 04:10:54PM -0700, Greg Kroah-Hartman wrote:
> > > On Fri, Aug 09, 2013 at 01:37:09PM -0700, Josh Cartwright wrote:
> 
> > > > +	"Example: Read 4 bytes starting at register address 0x1234 for SID 2\n"
> > > > +	"\n"
> > > > +	"echo 0x21234 > address\n"
> > > > +	"echo 4 > count\n"
> > > > +	"cat data\n"
> > > > +	"\n"
> > > > +	"Example: Write 3 bytes starting at register address 0x1008 for SID 1\n"
> > > > +	"\n"
> > > > +	"echo 0x11008 > address\n"
> > > > +	"echo 0x01 0x02 0x03 > data\n"
> > > > +	"\n"
> > > > +	"Note that the count file is not used for writes.  Since 3 bytes are\n"
> > > > +	"written to the 'data' file, then 3 bytes will be written across the\n"
> > > > +	"SPMI bus.\n\n";
> 
> > > The help file within the kernel is a nice touch :)
> 
> > > Or is this only for "debugging"?  If so, please document it as such.
> 
> > It's there because it provides a useful interface for debugging of the
> > controller code, and for simple peek/poke of the slave registers without
> > having a full driver in place.  Will document this.
> 
> This looks awfully like a version of the debugfs interfaces that regmap
> provides, and indeed the entire bus sounds like something that could
> idiomatically be supported via regmap.  Have you considered doing that?
> This would give access to standard tracepoints as well, plus the cache
> infrastructure.

It does indeed look like regmap might work out nicely for SPMI.  I
hadn't seriously considered it just due to a lack of familiarity. I'll
give it a shot and see if I run into any problems.

Thanks,
  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
