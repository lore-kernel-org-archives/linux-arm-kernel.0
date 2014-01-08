From: ijc@hellion.org.uk (Ian Campbell)
Date: Wed, 08 Jan 2014 21:24:16 +0000
Subject: [linux-sunxi] [ANNOUNCE] sunxi-babelfish (FEX-to-DT translator)
In-Reply-To: <20140108182906.GH2941@lukather>
References: <20140107220310.GD3103@lukather>
 <1389200137.27473.6.camel@kazak.uk.xensource.com>
 <20140108182906.GH2941@lukather>
Message-ID: <1389216256.7769.39.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-01-08 at 19:29 +0100, Maxime Ripard wrote:
> On Wed, Jan 08, 2014 at 04:55:37PM +0000, Ian Campbell wrote:
> > On Tue, 2014-01-07 at 23:03 +0100, Maxime Ripard wrote:
> > > Another nice thing about it is that a FEX-to-DT compiler comes at no
> > > cost afterwards. Since dtc is able to generate a DTS from
> > > /proc/device-tree, you can easily generate a DTS for your previously
> > > non-supported board using
> > > 
> > >   dtc -I fs -O dts -o my-board.dts /proc/device-tree/
> > 
> > I wonder if it might also be useful to compile this as a normal user
> > space application which takes the fex and produces the dtb (or dts)?
> 
> At the moment, no, libfdt only operates on DTB, so we would have to
> chain this somehow with dtc to at least do the DTB to DTS conversion I
> guess.
> 
> It's not something that I'm pretty fond of either. Or, I don't really
> see the benefit of it.
> 
> Let's say that you have such tool, I'm guessing one would want it to
> mass-convert fex files to DT. But then, you'd still have to boot that
> DT to be sure that everything is working, so you're pretty much losing
> the mass-convertion thing, since you would have boot this with a
> baremetal babelfish anyway.

I wasn't really thinking of mass conversion. just an easy way for people
to produce a starting point for their platform to send upstream.

> > I suppose producing something upstreamable would be different/harder
> > though, since it would need to not inline/merge the dtsi file but just
> > leave the include stmt. That's probably a different tool.
> 
> Yeah, dtc outputs a "flat" DTS, without any include, so you still need
> to edit it by hand to remove the common part, remove the duplicated
> pinctrl nodes, fix the phandle, etc.
> 
> But most of that can be scripted I guess.

I think this could be done as a separate tool which read a FEX and
outputted the dts directly (i.e. with printf). The output would have the
#include for the right dtsi in place and the appropriate overrides
derived from the FEX. That's not really anything like your
sunxi-babelfish though.

Ian.
