From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Oct 2017 17:10:53 +0100
Subject: [PATCH 0/3] arm64: cpuinfo: make /proc/cpuinfo more human-readable
In-Reply-To: <abeb1756-3635-2f86-131c-cd904731a308@redhat.com>
References: <20170926222324.17409-1-ahs3@redhat.com>
 <20170927103406.GC32150@leverpostej>
 <CAOZdJXUzo3JrHW1h6W3y3BnVq472NjPpaqTztzEODZnnMyvJRg@mail.gmail.com>
 <20171013142724.GA5893@leverpostej>
 <abeb1756-3635-2f86-131c-cd904731a308@redhat.com>
Message-ID: <20171020161053.ujw3spzizhgu4g7b@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On Mon, Oct 16, 2017 at 05:43:19PM -0600, Al Stone wrote:
> On 10/13/2017 08:27 AM, Mark Rutland wrote:
> > I certainly agree that exposing the information that we have is useful,
> > as I have stated several times. I'm not NAKing exposing this information
> > elsewhere.
> > 
> > If you want a consistent cross-architecture interface for this
> > information, then you need to propose a new one. That was we can
> > actually solve the underlying issues, for all architectures, without
> > breaking ABI.
> > 
> > I would be *very* interested in such an interface, and would be more
> > than happy to help.
> 
> I'm playing with some patches that do very similar things in sysfs, vs
> proc.  Is that better :)?

Exposing data under sysfs is certainly better, yes. :)

> Obviously, you'll have to see the patches to
> properly answer that, but what I'm playing with at present is placing
> this info in new entries in /sys/devices/cpu and/or /sys/devices/system,
> and generating some of the content based on what's already in header files
> (e.g., in cputype.h). 

My opposition to MIDR -> string mapping applies regardless of
location...

> The idea of course is to keep this new info from touching any existing
> info so we don't break compatibility -- does that feel like a better
> direction, at least?

... but otherwise this sounds good to me!

Thanks,
Mark.
