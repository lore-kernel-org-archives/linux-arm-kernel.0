From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Apr 2015 11:28:12 +0200
Subject: [GIT PULL] ARM perf updates for 4.1
In-Reply-To: <20150413091011.GA1582@arm.com>
References: <20150327172246.GN1562@arm.com>
 <CAMuHMdUvjqYSSTwFcyhn=ChCJWZsqvL1CAVWRgnid0=giD56Ag@mail.gmail.com>
 <20150413091011.GA1582@arm.com>
Message-ID: <20150413092812.GC432@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Mon, Apr 13, 2015 at 10:10:12AM +0100, Will Deacon wrote:
> On Tue, Apr 07, 2015 at 04:05:40PM +0100, Geert Uytterhoeven wrote:
> > On Fri, Mar 27, 2015 at 6:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > Will Deacon (1):
> > >       ARM: pmu: add support for interrupt-affinity property
> > 
> > As most DTSes lack this property, we now get scary warnings:
> > 
> >         CPU PMU: Failed to parse <no-node>/interrupt-affinity[0]
> 
> That's a harmless warning (i.e. perf will `work' as before), but I'd like to
> print something to say that we didn't find the property.

Shouldn't we have a warning only if that property makes some kind of
sense?

I mean, I agree on the fact that we want this property if this is an
SPI, but if it is a PPI, it doesn't make any sense to have this
property, and this is very well documented in the binding
documentation.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150413/76f8ce8b/attachment.sig>
