From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Jan 2010 14:27:15 -0800
Subject: [GIT PULL] omap fixes for 2.6.33-rc3
In-Reply-To: <alpine.DEB.2.00.1001081502480.19243@utopia.booyaka.com>
References: <20100108180912.GC6831@atomide.com>
	<alpine.LFD.2.00.1001081014090.7821@localhost.localdomain>
	<20100108182236.GE6831@atomide.com>
	<alpine.DEB.2.00.1001081502480.19243@utopia.booyaka.com>
Message-ID: <20100108222715.GC2879@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [100108 14:03]:
> Hello Linus, Tony,
> 
> On Fri, 8 Jan 2010, Tony Lindgren wrote:
> 
> > * Linus Torvalds <torvalds@linux-foundation.org> [100108 10:18]:
> > > 
> > > There are other problems with that branch too - the "committer" 
> > > information is pure sh*t. It says "paul <paul@twilight.(none)>", so quite 
> > > frankly, somebody hasn't even read the very first chapter of just about 
> > > every single git documentation that is out there.
> > > 
> > > And now that I noticed, I see that the crap-for-brains committer info has 
> > > been going on for a long time, and I just hadn't looked closely enough 
> > > before. I didn't look closely enough to see if the rebase problem had also 
> > > happened before.
> 
> Sorry - I seem to be the crap-for-brains committer.  Will fix -

Here's a check for unconfigured GIT_AUTHOR_EMAIL and GIT_COMMITTER_EMAIL:

$ git log --pretty=oneline --author=".(none)" --committer=".(none)" v2.6.33-rc1..

If it returns results, something is wrong.

Should we have some check like this in place for all pulls?

Regards,

Tony
