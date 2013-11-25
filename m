From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 25 Nov 2013 15:28:43 +0000
Subject: [PATCH v4] ARM: vexpress/TC2: Implement MCPM power_down_finish()
In-Reply-To: <1384879457.3381.21.camel@linaro1.home>
References: <20131108185613.GF2602@localhost.localdomain>
 <1384160080.4495.2.camel@hornet>
 <20131111134030.GA2391@e103592.cambridge.arm.com>
 <1384180911.4495.77.camel@hornet>
 <alpine.LFD.2.10.1311111134200.9667@knanqh.ubzr>
 <1384879457.3381.21.camel@linaro1.home>
Message-ID: <20131125152837.GA2302@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 04:44:17PM +0000, Jon Medhurst (Tixy) wrote:
> On Mon, 2013-11-11 at 11:35 -0500, Nicolas Pitre wrote:
> > On Mon, 11 Nov 2013, Pawel Moll wrote:
> > 
> > > On Mon, 2013-11-11 at 13:40 +0000, Dave P Martin wrote:
> > > > On Mon, Nov 11, 2013 at 08:54:40AM +0000, Pawel Moll wrote:
> > > > > On Fri, 2013-11-08 at 18:56 +0000, Dave Martin wrote:
> > > > > > Hi Pawel, did you manage to take a look at this?
> > > > > > 
> > > > > > I want to have something in place here, otherwise there's a nice WARN_ON
> > > > > > to look forward to in 3.13 :)
> > > > > > 
> > > > > > I don't think I've seen a response from you so far?
> > > > > 
> > > > > On Fri, 2013-11-01 at 12:21 +0000, Pawel Moll wrote:
> > > > > > PS. I actually had a look at the patches after you reminded me last week
> > > > > > (two weeks ago? ;-)
> > > > > 
> > > > > Acked-by: Pawel Moll <pawel.moll@arm.com>
> > > > 
> > > > Thanks
> > > > 
> > > > What's the best way to send this upstream?
> > > 
> > > Through arm-soc, I believe. Generally Nico was pulling this stuff into
> > > his PM branch (except for the one case of me helping out with the SPC).
> > > 
> > > Nevertheless I'm happy to queue it if you want me to.
> > 
> > Please do so as I've nothing queued on my side at the moment.
> 
> I notice that this isn't in linux-next, has it fallen through the
> cracks? Its absence produces a rather ugly warning and backtrace on
> TC2...

There wasn't really agreement on this until the merge window opened, and
it didn't seem worth bothering people during the deluge, since it's
localised and pretty orthogonal.

However, since TC2 is no longer technically compatible with MCPM and
this shouldn't break anything else, I will see if I can justify it to
arm-soc as a fix for 3.13, rather than waiting for the 3.14 cycle.

Cheers
---Dave
