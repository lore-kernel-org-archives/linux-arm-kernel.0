From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Apr 2015 11:21:43 +0100
Subject: [GIT PULL] ARM perf updates for 4.1
In-Reply-To: <20150413092812.GC432@lukather>
References: <20150327172246.GN1562@arm.com>
 <CAMuHMdUvjqYSSTwFcyhn=ChCJWZsqvL1CAVWRgnid0=giD56Ag@mail.gmail.com>
 <20150413091011.GA1582@arm.com> <20150413092812.GC432@lukather>
Message-ID: <20150413102031.GA2869@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 13, 2015 at 10:28:12AM +0100, Maxime Ripard wrote:
> On Mon, Apr 13, 2015 at 10:10:12AM +0100, Will Deacon wrote:
> > On Tue, Apr 07, 2015 at 04:05:40PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, Mar 27, 2015 at 6:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > > Will Deacon (1):
> > > >       ARM: pmu: add support for interrupt-affinity property
> > > 
> > > As most DTSes lack this property, we now get scary warnings:
> > > 
> > >         CPU PMU: Failed to parse <no-node>/interrupt-affinity[0]
> > 
> > That's a harmless warning (i.e. perf will `work' as before), but I'd like to
> > print something to say that we didn't find the property.
> 
> Shouldn't we have a warning only if that property makes some kind of
> sense?
> 
> I mean, I agree on the fact that we want this property if this is an
> SPI, but if it is a PPI, it doesn't make any sense to have this
> property, and this is very well documented in the binding
> documentation.

Yes, that's a good point; for PPIs, the warning is nonsensical. I'll cook
a fix.

Cheers,

Will
