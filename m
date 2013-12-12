From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Thu, 12 Dec 2013 13:42:55 +0000
Subject: [PATCH 5/6] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20131212122236.GJ11044@sirena.org.uk>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-5-git-send-email-broonie@kernel.org>
 <20131211144755.GF596@darko.cambridge.arm.com>
 <20131211173142.GD11468@sirena.org.uk>
 <alpine.LFD.2.10.1312111414500.15948@knanqh.ubzr>
 <20131212115639.GD28621@e103034-lin>
 <20131212122236.GJ11044@sirena.org.uk>
Message-ID: <20131212134255.GF28621@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 12:22:36PM +0000, Mark Brown wrote:
> On Thu, Dec 12, 2013 at 11:56:40AM +0000, Morten Rasmussen wrote:
> 
> > > > I'm also worried about putting numbers into the DT now with all the
> > > > scheduler work going on, this time next year we may well have a
> > > > completely different idea of what we want to tell the scheduler.  It may
> > > > be that we end up being able to explicitly tell the scheduler about
> > > > things like the memory architecture, or that the scheduler just gets
> > > > smarter and can estimate all this stuff at runtime.  
> 
> > I agree. We need to sort the scheduler side out first before we commit
> > to anything. If we are worried about including code into v8 that we are
> > going to change later, then it is probably better to leave this part
> > out. See my response to Mark's patch subset with the same patch for
> > details (I didn't see this thread until afterwardsi - sorry).
> 
> My take on change is that we should be doing as good a job as we can
> with the scheduler we have so users get whatever we're able to deliver
> at the current time.  Having to change in kernel code shouldn't be that
> big a deal, especially with something like this where the scheduler is
> free to ignore what it's told without churning the interface.

Fair enough. I just wanted to make sure that people knew about the
cpu_power issues before deciding whether to do the same for v8.

Morten
