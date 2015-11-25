From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 25 Nov 2015 13:09:09 -0500 (EST)
Subject: [PATCH] arm64: restore bogomips information in /proc/cpuinfo
In-Reply-To: <5655F09E.1060004@linaro.org>
References: <1447870505-19319-1-git-send-email-yang.shi@linaro.org>
 <56554AE9.5070901@jonmasters.org>
 <alpine.LFD.2.20.1511250958370.22569@knanqh.ubzr>
 <5655F09E.1060004@linaro.org>
Message-ID: <alpine.LFD.2.20.1511251303220.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Nov 2015, Shi, Yang wrote:

> On 11/25/2015 7:16 AM, Nicolas Pitre wrote:
> > On Wed, 25 Nov 2015, Jon Masters wrote:
> >
> > > On 11/18/15, 1:15 PM, Yang Shi wrote:
> > >
> > > > As what Pavel Machek reported [1], some userspace applications depend on
> > > > bogomips showed by /proc/cpuinfo.
> > > >
> > > > Although there is much less legacy impact on aarch64 than arm, but it
> > > > does
> > > > break libvirt.
> > > >
> > > > Basically, this patch reverts commit
> > > > 326b16db9f69fd0d279be873c6c00f88c0a4aad5
> > > > ("arm64: delay: don't bother reporting bogomips in /proc/cpuinfo"), but
> > > > with
> > > > some tweak due to context change.
> > >
> > > On a total tangent, it would be ideal to (eventually) have something
> > > reported
> > > in /proc/cpuinfo or dmesg during boot that does "accurately" map back to
> > > the
> > > underlying core frequency (as opposed to the generic timer frequency). I
> > > have
> > > seen almost countless silly situations in the industry (external to my own
> > > organization) in which someone has taken a $VENDOR_X reference system that
> > > they're not supposed to run benchmarks on, and they've done it anyway. But
> > > usually on some silicon that's clocked multiples under what production
> > > would
> > > be. Then silly rumors about performance get around because nobody can do
> > > simple arithmetic and notice that they ought to have at least divided by
> > > some
> > > factor.
> >
> > Be my guest my friend.
> >
> > According to the common wisdom, the bogomips reporting is completely
> > senseless at this point and no one should expect anything useful from
> > it. Therefore I attempted to rehabilitate some meaning into it given
> > that we just can't get rid of it either and it continues to cause
> > dammage. You certainly saw where that has led me.
> 
> Or we may create a new one, i.e. "cpu MHz" like x86? Then we keep both in
> cpuinfo so that the userspace could adopt it gradually?

The problem is that CPU MHz is not known/discoverable on all platforms.  
The initial spirit behind bogomips was close to CPU clock with rough 
precision that could be determined at run time.

But CPU MHz, when available, has the merit of not being open to 
interpretation.


Nicolas
