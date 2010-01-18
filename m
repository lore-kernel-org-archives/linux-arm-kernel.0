From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jan 2010 15:01:52 +0000
Subject: flush_dcache_page does too much?
In-Reply-To: <20100118145731.GA14523@desktop>
References: <20100118131346.GA11589@desktop>
	<20100118133304.GA29645@n2100.arm.linux.org.uk>
	<20100118135431.GA12496@desktop>
	<20100118140005.GD2695@n2100.arm.linux.org.uk>
	<20100118141530.GA13394@desktop>
	<20100118144418.GE2695@n2100.arm.linux.org.uk>
	<20100118145731.GA14523@desktop>
Message-ID: <20100118150152.GF2695@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 10:57:31PM +0800, anfei wrote:
> On Mon, Jan 18, 2010 at 02:44:18PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 18, 2010 at 10:15:30PM +0800, anfei wrote:
> > > On Mon, Jan 18, 2010 at 02:00:05PM +0000, Russell King - ARM Linux wrote:
> > > > On Mon, Jan 18, 2010 at 09:54:31PM +0800, anfei wrote:
> > > > > Do you mean this implementation can ensure the coherence between write
> > > > > and shared mmapings?  But it's easy to reproduce the alias problem by
> > > > > this simple testcase (w/o error handler) on omap2430 with VIPT cache:
> > > > 
> > > > Your program doesn't do anything to identify any problem.  You don't
> > > > even say _what_ problem you see with this program.
> > > > 
> > > Sorry for that.
> > > 
> > > > If you have a specific case which fails, please show the problem, please
> > > > describe exactly the behaviour that you see, and what you expect to see.
> > 
> > Are you using a write allocate cache?
> 
> I guess not, because this line is neccessary to reproduce the issue:
> 	tmp = *(addr+0);
> If it's write allocate, this line may not be neccessary, since it's just
> a read (and cache the data).

It makes no sense then - without write allocate, writes will go straight
through to the underlying page, bypassing the cache.

Sorry, no idea.
